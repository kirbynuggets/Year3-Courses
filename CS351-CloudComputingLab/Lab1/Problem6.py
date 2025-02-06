'''
Problem 6:
Write a function to get all the unique elements from a given list. Your solution must use
`set` to solve this.
Input: [1,1,3,2,3,2,3,2,2]
Output: {1,2,3}
'''

def unique_elements(list1):
    unique_set = set(list1)  # getting unique elements by converting list to a set
    print(unique_set)  # print the set of unique elements

def main():
    input_str = input("Enter values for the list separated by spaces: ")  # get user input for list values separated by spaces
    list1 = [int(x) for x in input_str.split()]  # convert space-separated values to integers and create a list

    unique_elements(list1)  # calling function

if __name__ == "__main__":
    main()  # executing main function
