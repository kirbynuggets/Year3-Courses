'''
Problem 14:
Write a function to find the product of all the numbers in a list using `functools.reduce` in
some capacity.
Input : [1, 2, 3, 4, 5]
Output : 120
'''

from functools import reduce
import operator

def product_of_list(numbers):
    # Using reduce with operator.mul to compute the product of all numbers in the list
    return reduce(operator.mul, numbers, 1)

def main():
    input_str = input("Enter numbers separated by spaces: ")  # user input for numbers
    numbers = [int(x) for x in input_str.split()]  # Converting input string into a list of integers

    result = product_of_list(numbers)  # Calling function
    print(result)  # printing result

if __name__ == "__main__":
    main()  # Executing main function
