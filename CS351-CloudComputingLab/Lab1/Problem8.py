'''
Problem 8:
Write a function that takes an integer n and outputs a `dict` containing keys from 0, 1, 2, ..., n.
Each key is mapped to a list containing the square and cube of the number.
Input: 3
Output:
{
 0: [0, 0],
 1: [1, 1],
 2: [4, 8],
 3: [9, 27]
}
'''

def generate_dict(n):
    result_dict = {}  # initialize an empty dictionary

    for i in range(n + 1):  # iterating from 0 to n
        square = i ** 2  # calculate the square of i
        cube = i ** 3  # calculate the cube of i
        result_dict[i] = [square, cube]  # map the key to the list [square, cube]

    return result_dict  # return the resulting dictionary

def main():
    n = int(input("Enter an integer n: "))  # get user input for the integer n
    result = generate_dict(n)  # calling function to generate the dictionary
    print(result)  # print the resulting dictionary

if __name__ == "__main__":
    main()  # executing main function
