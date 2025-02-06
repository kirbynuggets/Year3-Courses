''' Problem 1:
 Write a function to break down a string into a list of characters.
 Input: "abc"
 Output: ['a','b','c']'''
def str_to_list():
    a= input("Enter String: ") # user input
    print(list(a)) # converting & printing string to list

def main():
    str_to_list() # function calling

if __name__ == "__main__":
    main() # executing main function