'''Problem 2:
 Write a function to reverse output of the problem 1 back into a string.
 Input: ['a','b','c']
 Output: "abc"
 '''
def list_to_str():
    input_str = input("Enter values for the list separated by spaces: ")  # get user input for list values
    list1 = input_str.split()  # split the input into a list of strings

    string = ''.join(list1)  # join the list elements into a single string
    print(string)  # display the resulting string

def main():
    list_to_str()  # call the function to process and display the string

if __name__ == "__main__":
    main()  # run the main function
