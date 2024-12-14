"""Write a python program by taking a number as input and check whether it is even or odd
using the if else condition."""

number = int(input("Enter a number: "))

if number % 2 == 0:
    print(f"{number} is even.")
else:
    print(f"{number} is odd.")
