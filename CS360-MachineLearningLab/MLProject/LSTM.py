import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import tensorflow as tf
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import mean_absolute_percentage_error
from keras import Model
from keras.layers import Input, Dense, Dropout, LSTM

# Read and preprocess the data
df = pd.read_csv('dataset.csv')

# Convert date format and sort - updated to handle YYYY-MM-DD format
df['Date'] = pd.to_datetime(df['Date'])  # Let pandas auto-detect the format
df.sort_values(by='Date', ascending=True, inplace=True)
df.reset_index(drop=True, inplace=True)

# Drop Volume and Change% columns as in the original code
df.drop(['Vol.', 'Change %'], axis=1, inplace=True)

# Clean numeric columns
numeric_cols = df.columns.drop(['Date'])
df[numeric_cols] = df[numeric_cols].replace({',': ''}, regex=True)
df[numeric_cols] = df[numeric_cols].astype('float64')

# Plot the initial data
plt.figure(figsize=(15, 6), dpi=150)
plt.plot(df.Date, df.Price, color='black', lw=2)
plt.title('Gold Price History Data', fontsize=15)
plt.xlabel('Date', fontsize=12)
plt.ylabel('Price', fontsize=12)
plt.grid(True)
plt.show()

# Split into training and test sets (last 6 months for testing)
test_size = 180  # Approximately 6 months of trading days
print(f"Total dataset size: {len(df)}")
print(f"Test set size: {test_size}")

# Plot train-test split
plt.figure(figsize=(15, 6), dpi=150)
plt.rcParams['axes.facecolor'] = 'white'
plt.plot(df.Date[:-test_size], df.Price[:-test_size], color='black', lw=2)
plt.plot(df.Date[-test_size:], df.Price[-test_size:], color='blue', lw=2)
plt.title('Gold Price Training and Test Sets', fontsize=15)
plt.xlabel('Date', fontsize=12)
plt.ylabel('Price', fontsize=12)
plt.legend(['Training set', 'Test set'], loc='upper left', prop={'size': 15})
plt.grid(True)
plt.show()

# Scale the data
scaler = MinMaxScaler()
scaler.fit(df.Price.values.reshape(-1,1))

# Prepare sequences
window_size = 60

# Prepare training data
train_data = df.Price[:-test_size]
train_data = scaler.transform(train_data.values.reshape(-1,1))

X_train = []
y_train = []

for i in range(window_size, len(train_data)):
    X_train.append(train_data[i-window_size:i, 0])
    y_train.append(train_data[i, 0])

# Prepare test data
test_data = df.Price[-test_size-window_size:]
test_data = scaler.transform(test_data.values.reshape(-1,1))

X_test = []
y_test = []

for i in range(window_size, len(test_data)):
    X_test.append(test_data[i-window_size:i, 0])
    y_test.append(test_data[i, 0])

# Convert to numpy arrays and reshape
X_train = np.array(X_train)
X_test = np.array(X_test)
y_train = np.array(y_train)
y_test = np.array(y_test)

X_train = np.reshape(X_train, (X_train.shape[0], X_train.shape[1], 1))
X_test = np.reshape(X_test, (X_test.shape[0], X_test.shape[1], 1))
y_train = np.reshape(y_train, (-1,1))
y_test = np.reshape(y_test, (-1,1))

print('X_train Shape: ', X_train.shape)
print('y_train Shape: ', y_train.shape)
print('X_test Shape:  ', X_test.shape)
print('y_test Shape:  ', y_test.shape)

# Define the model
def define_model():
    input1 = Input(shape=(window_size,1))
    x = LSTM(units=64, return_sequences=True)(input1)  
    x = Dropout(0.2)(x)
    x = LSTM(units=64, return_sequences=True)(x)
    x = Dropout(0.2)(x)
    x = LSTM(units=64)(x)
    x = Dropout(0.2)(x)
    x = Dense(32, activation='relu')(x)
    dnn_output = Dense(1)(x)

    model = Model(inputs=input1, outputs=[dnn_output])
    model.compile(loss='mean_squared_error', optimizer='Nadam')
    model.summary()
    
    return model

# Train the model
model = define_model()
history = model.fit(X_train, y_train, epochs=150, batch_size=32, validation_split=0.1, verbose=1)

# Evaluate the model
result = model.evaluate(X_test, y_test)
y_pred = model.predict(X_test)

MAPE = mean_absolute_percentage_error(y_test, y_pred)
Accuracy = 1 - MAPE

print("\nModel Performance:")
print("Test Loss:", result)
print("Test MAPE:", MAPE)
print("Test Accuracy:", Accuracy)

# Plot training history
plt.figure(figsize=(12, 6))
plt.plot(history.history['loss'], label='Training Loss')
plt.plot(history.history['val_loss'], label='Validation Loss')
plt.title('Model Loss During Training')
plt.xlabel('Epoch')
plt.ylabel('Loss')
plt.legend()
plt.grid(True)
plt.show()

# Inverse transform predictions
y_test_true = scaler.inverse_transform(y_test)
y_test_pred = scaler.inverse_transform(y_pred)

# Plot final results
plt.figure(figsize=(15, 6), dpi=150)
plt.plot(df['Date'].iloc[:-test_size], scaler.inverse_transform(train_data), color='black', lw=2)
plt.plot(df['Date'].iloc[-test_size:], y_test_true, color='blue', lw=2)
plt.plot(df['Date'].iloc[-test_size:], y_test_pred, color='red', lw=2)
plt.title('Model Performance on Gold Price Prediction', fontsize=15)
plt.xlabel('Date', fontsize=12)
plt.ylabel('Price', fontsize=12)
plt.legend(['Training Data', 'Actual Test Data', 'Predicted Test Data'], loc='upper left', prop={'size': 15})
plt.grid(True)
plt.show()

# Print some statistics
print("\nPrediction Statistics:")
print(f"Average Actual Price: {np.mean(y_test_true):,.2f}")
print(f"Average Predicted Price: {np.mean(y_test_pred):,.2f}")
print(f"Standard Deviation of Actual Prices: {np.std(y_test_true):,.2f}")
print(f"Standard Deviation of Predicted Prices: {np.std(y_test_pred):,.2f}")