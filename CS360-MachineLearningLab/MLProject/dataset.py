import yfinance as yf
import pandas as pd

# Define the ticker symbol for gold futures
ticker = 'GC=F'
# Fetch historical data for the past 20 years in USD
data = yf.download(ticker, start="2004-01-01", end="2024-01-01")

# Example exchange rate from USD to INR (you may want to get the latest rate)
usd_to_inr = 84.09  # replace with the current exchange rate

# Convert all price columns to INR
data[['Open', 'High', 'Low', 'Close', 'Adj Close']] = data[['Open', 'High', 'Low', 'Close', 'Adj Close']] * usd_to_inr

# Save the data to a CSV file
data.to_csv('dataset.csv')

print("Data has been saved to 'gold_price_data_inr.csv' with values in INR")
