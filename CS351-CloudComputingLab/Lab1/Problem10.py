'''
Problem 10:
Write a function that uses list comprehension to generate the squares of 0 to n.
Input: 5
Output: [0, 1, 4, 9, 16, 25]
'''

def squares(n):
    result = [i * i for i in range(n + 1)]  # List comprehension to generate squares from 0 to n
    print(result)  # Print the list of squares

def main():
    num = int(input("Enter a number: "))  # User input for the number n
    squares(num)  # Call the function with the input number

if __name__ == "__main__":
    main()  # Execute the main function
