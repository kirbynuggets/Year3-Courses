'''
Problem 11:
Write a function that uses dictionary comprehension to generate a mapping from (0 to n)
to their squares.
Input : 5
Output : {0:0, 1:1, 2:4, 3:9, 4:16, 5:25}
'''

def squares_dict(num):
    # creating dictionary with numbers and their squares
    dict1 = {i: i*i for i in range(num + 1)}
    print(dict1)  # printing the dictionary

def main():
    num = int(input("Enter a number: "))  # user input for the number
    squares_dict(num)  # calling function

if __name__ == "__main__":
    main()  # executing main function
