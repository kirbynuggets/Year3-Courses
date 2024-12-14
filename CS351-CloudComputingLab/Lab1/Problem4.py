''' Problem 4:
 Write a function to sort a given list of numbers in descending order.
 Input: [1,2,3,4,5]
 Output: [5,4,3,2,1]
 '''
def sort_desc(list1):
    list1.sort(reverse=True)  # sorting the list in descending order
    print(list1)  # printing the sorted list

def main():
    input_str = input("Enter values for the list separated by spaces: ")  # user input for list values separated by spaces
    list1 = [int(x) for x in input_str.split()]  # converting space-separated values to integers and creating a list

    sort_desc(list1)  # calling the function to sort and print the list in descending order

if __name__ == "__main__":
    main()  # executing the main function
