''' Problem 3:
 Write a function to generate a list of n random numbers. Use the inbuilt `random`
 module.
 Input: 5
 Output: [5,2,3,1,5]
 '''

import random

def n_random_nums(n):
    list1 = []  # initializing an empty list

    for i in range(0, n, 1):  # iterating n times
        num = random.randint(1, 100)  # generating a random number between 1 and 100
        list1.append(num)  # adding the random number to the list

    print(list1)  # printing the list of random numbers

def main():
    n = int(input("Enter n: "))  # user input for the number of random numbers
    n_random_nums(n)  # calling the function to generate and print random numbers

if __name__ == "__main__":
    main()  # executing the main function
