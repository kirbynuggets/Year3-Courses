import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.preprocessing import MinMaxScaler
from keras.models import Sequential
from keras.layers import LSTM, Dense, Dropout
from sklearn.metrics import mean_squared_error

# Load your dataset (replace with actual file path)
df = pd.read_csv('gold_price.csv')

# Preprocess the data
df['Date'] = pd.to_datetime(df['Date'])
df.set_index('Date', inplace=True)

# Sort the data by date to ensure correct time-series order
df.sort_index(ascending=True, inplace=True)

# Get the 'Price' column for prediction (replace 'Price' with the actual column name in your dataset)
data = df[['Price']]

# Feature scaling (normalization)
scaler = MinMaxScaler(feature_range=(0,1))
scaled_data = scaler.fit_transform(data)

# Prepare training and testing datasets
train_size = int(len(scaled_data) * 0.8)
train_data = scaled_data[:train_size]
test_data = scaled_data[train_size:]

# Create sequences of data for LSTM input
def create_sequences(data, time_step=60):
    X, y = [], []
    for i in range(time_step, len(data)):
        X.append(data[i-time_step:i, 0])
        y.append(data[i, 0])
    return np.array(X), np.array(y)

time_step = 60  # Using 60 days of historical data to predict the next day
X_train, y_train = create_sequences(train_data, time_step)
X_test, y_test = create_sequences(test_data, time_step)

# Reshape the data for LSTM input
X_train = X_train.reshape(X_train.shape[0], X_train.shape[1], 1)
X_test = X_test.reshape(X_test.shape[0], X_test.shape[1], 1)

# Build the LSTM model
model = Sequential()
model.add(LSTM(units=100, return_sequences=True, input_shape=(X_train.shape[1], 1)))
model.add(Dropout(0.2))
model.add(LSTM(units=100, return_sequences=False))
model.add(Dropout(0.2))
model.add(Dense(units=1))

# Compile the model
model.compile(optimizer='adam', loss='mean_squared_error')

# Train the model
history = model.fit(X_train, y_train, epochs=20, batch_size=32, validation_data=(X_test, y_test))

# Predict the test data
predictions = model.predict(X_test)
predictions = scaler.inverse_transform(predictions)

# Rescale y_test for comparison
y_test_rescaled = scaler.inverse_transform(y_test.reshape(-1, 1))

# Calculate RMSE (Root Mean Squared Error)
rmse = np.sqrt(mean_squared_error(y_test_rescaled, predictions))
print(f"Test RMSE: {rmse}")

# Accuracy (we'll consider accuracy based on percentage difference)
def calculate_accuracy(true, pred):
    diff = np.abs((true - pred) / true)
    accuracy = 100 - np.mean(diff) * 100
    return accuracy

accuracy = calculate_accuracy(y_test_rescaled, predictions)
print(f"Model Accuracy: {accuracy:.2f}%")

# Plot the results
plt.figure(figsize=(14,5))
plt.plot(y_test_rescaled, color='blue', label='Actual Gold Prices')
plt.plot(predictions, color='red', label='Predicted Gold Prices')
plt.title('Gold Price Prediction')
plt.xlabel('Time')
plt.ylabel('Gold Price')
plt.legend()
plt.show()
