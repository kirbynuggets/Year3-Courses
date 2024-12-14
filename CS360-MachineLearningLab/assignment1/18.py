"""Write a Pandas program to create today's date."""

import pandas as pd  # Importing Pandas for handling data

# Creating today's date
today_date = pd.Timestamp.today().date()

# Displaying today's date
print("Today's date is:", today_date)
