'''
Problem 7:
Write a function to get the first repeating element from a list. Your solution must use
`set` to solve this.
Input: [1,2,3,4,5,1,2]
Output: 1
'''

def first_repeating(list1):
    seen = set()  # initialize an empty set to track seen elements

    for number in list1:
        if number in seen:
            return number  # return the first repeating element
        seen.add(number)  # add the number to the set if not already seen

    return None  # return None if no repeating element is found

def main():
    input_str = input("Enter values for the list separated by spaces: ")  # get user input for list values separated by spaces
    list1 = [int(x) for x in input_str.split()]  # convert space-separated values to integers and create a list

    result = first_repeating(list1)  # calling function
    if result is not None:
        print(result)  # print the first repeating element
    else:
        print("No repeating element found")  # inform the user if there are no repeating elements

if __name__ == "__main__":
    main()  # executing main function
