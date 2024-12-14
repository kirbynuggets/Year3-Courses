'''
Problem 5:
Write a function to get the frequency of each number in a list of numbers. Use a Python
dict to solve this.
Input: [1,1,3,2,3,2,3,2,2]
Output: {1: 2, 3: 3, 2: 4}
'''

def get_frequency(list1):
    frequency_dict = {}  # initialize an empty dictionary to keep track of frequencies

    for number in list1:
        if number in frequency_dict:
            frequency_dict[number] += 1  # increase the count for existing number
        else:
            frequency_dict[number] = 1  # set count to 1 for new number

    return frequency_dict  # return the dictionary with frequencies

def main():
    input_str = input("Enter values for the list separated by spaces: ")  # get user input for list values separated by spaces
    list1 = [int(x) for x in input_str.split()]  # convert space-separated values to integers and create a list

    frequency = get_frequency(list1)  # call the function to get the frequency dictionary
    print(frequency)  # print the frequency dictionary

if __name__ == "__main__":
    main()  # run the main function
