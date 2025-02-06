'''
Problem 9:
Given two lists of equal size, write a function to create tuples of each consecutive
element having the same index. Use `zip` in some capacity
to solve this.
Input: [1,2,3,4], ['a','b','c','d']
Output: [(1,'a'), (2,'b'), (3,'c'), (4,'d')]
'''

def create_tuples(list1, list2):
    result = list(zip(list1, list2))  # create tuples of elements with the same index from both lists
    return result  # return the list of tuples

def main():
    list1 = [int(x) for x in input("Enter values for the first list separated by spaces: ").split()]  # get user input for the first list
    list2 = input("Enter values for the second list separated by spaces: ").split()  # get user input for the second list

    result = create_tuples(list1, list2)  # calling function to create tuples
    print(result)  # print the resulting list of tuples

if __name__ == "__main__":
    main()  # executing main function
