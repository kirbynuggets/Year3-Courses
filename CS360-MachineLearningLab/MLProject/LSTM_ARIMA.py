import optuna
import pandas as pd
import numpy as np
from statsmodels.tsa.arima.model import ARIMA
from sklearn.preprocessing import MinMaxScaler
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, LSTM
from tensorflow.keras.callbacks import EarlyStopping
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt
import mplfinance as mpf
import itertools

# Load dataset
data = pd.read_csv('dataset.csv', index_col='Date', parse_dates=True)
print(data.head())

# Data preprocessing
scaler = MinMaxScaler(feature_range=(0, 1))
data_scaled = scaler.fit_transform(data[['Close']])

# Split data into training, validation and test sets
train_size = int(len(data_scaled) * 0.7)
val_size = int(len(data_scaled) * 0.2)
test_size = len(data_scaled) - train_size - val_size
train, val, test = data_scaled[:train_size], data_scaled[train_size:train_size+val_size], data_scaled[train_size+val_size:]

# Prepare data for LSTM
def create_lstm_dataset(data, time_step=1):
    X, Y = [], []
    for i in range(len(data) - time_step):
        a = data[i:(i + time_step), 0]
        X.append(a)
        Y.append(data[i + time_step, 0])
    return np.array(X), np.array(Y)

time_step = 60
X_train, y_train = create_lstm_dataset(train, time_step)
X_val, y_val = create_lstm_dataset(val, time_step)
X_test, y_test = create_lstm_dataset(test, time_step)

X_train = X_train.reshape(X_train.shape[0], X_train.shape[1], 1)
X_val = X_val.reshape(X_val.shape[0], X_val.shape[1], 1)
X_test = X_test.reshape(X_test.shape[0], X_test.shape[1], 1)

# Grid Search for ARIMA
p = d = q = range(0, 3)
pdq = list(itertools.product(p, d, q))

best_arima_score, best_arima_params = float("inf"), None

for param in pdq:
    try:
        model = ARIMA(scaler.inverse_transform(train), order=param)
        results = model.fit()
        if results.aic < best_arima_score:
            best_arima_score, best_arima_params = results.aic, param
    except:
        continue

print(f'Best ARIMA params: {best_arima_params}, AIC: {best_arima_score}')

# Bayesian Optimization for LSTM
def build_lstm_model(trial):
    model = Sequential()
    model.add(LSTM(units=trial.suggest_int('units1', 32, 512, step=32), return_sequences=True, input_shape=(time_step, 1)))
    model.add(LSTM(units=trial.suggest_int('units2', 32, 512, step=32), return_sequences=False))
    model.add(Dense(25))
    model.add(Dense(1))
    model.compile(optimizer='adam', loss='mean_squared_error')
    return model

def objective(trial):
    model = build_lstm_model(trial)
    early_stopping = EarlyStopping(monitor='val_loss', patience=10, restore_best_weights=True)
    model.fit(X_train, y_train, epochs=50, batch_size=trial.suggest_int('batch_size', 16, 128, step=16), validation_data=(X_val, y_val), verbose=1, callbacks=[early_stopping])
    val_loss = model.evaluate(X_val, y_val, verbose=0)
    return val_loss

study = optuna.create_study(direction='minimize')
study.optimize(objective, n_trials=50)
best_trial = study.best_trial
print(f"Best hyperparameters: {best_trial.params}")

# Use best hyperparameters to build the model
best_model = build_lstm_model(best_trial)
best_model.fit(X_train, y_train, epochs=50, batch_size=best_trial.params['batch_size'], validation_data=(X_val, y_val), verbose=1, callbacks=[EarlyStopping(monitor='val_loss', patience=10, restore_best_weights=True)])

# Function for ARIMA Model with scaling correction
def arima_forecast(train_data, test_data, order=(5, 1, 0)):
    train_unscaled = scaler.inverse_transform(train_data)
    model = ARIMA(train_unscaled, order=order)
    arima_model = model.fit()
    forecast_unscaled = arima_model.forecast(steps=len(test_data))
    forecast_scaled = scaler.transform(forecast_unscaled.reshape(-1, 1))
    return forecast_scaled

# Assuming the best ARIMA parameters
arima_forecasted = arima_forecast(train, test, order=best_arima_params)

# LSTM Predictions and scaling correction
lstm_train_predict = best_model.predict(X_train)
lstm_val_predict = best_model.predict(X_val)
lstm_test_predict = best_model.predict(X_test)

lstm_train_predict = scaler.inverse_transform(lstm_train_predict)
lstm_val_predict = scaler.inverse_transform(lstm_val_predict)
lstm_test_predict = scaler.inverse_transform(lstm_test_predict)

# Calculate accuracy
train_rmse = np.sqrt(mean_squared_error(scaler.inverse_transform(train[time_step:]), lstm_train_predict))
val_rmse = np.sqrt(mean_squared_error(scaler.inverse_transform(val[time_step:]), lstm_val_predict))
test_rmse = np.sqrt(mean_squared_error(scaler.inverse_transform(test[time_step:]), lstm_test_predict))

print(f'Train RMSE: {train_rmse}')
print(f'Validation RMSE: {val_rmse}')
print(f'Test RMSE: {test_rmse}')

# Hybrid Forecast with scaling adjustments
combined_forecast = (arima_forecasted[:len(lstm_test_predict)] + lstm_test_predict[:, 0]) / 2

# Visualize results
plt.figure(figsize=(12, 6))
plt.plot(scaler.inverse_transform(data_scaled), label="Actual Data")
plt.plot(range(len(train), len(train) + len(combined_forecast)), combined_forecast, color="green", label="Hybrid Model Forecast")
plt.legend()
plt.show()

# Candlestick visualization
data_candlestick = pd.read_csv('dataset.csv', index_col='Date', parse_dates=True)
mpf.plot(data_candlestick, type='candle', style='charles', title='Stock Price', ylabel='Price')

print("Predicted prices for the next 30 days:")
print(combined_forecast[:30])