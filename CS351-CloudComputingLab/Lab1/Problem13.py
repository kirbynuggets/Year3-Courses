'''
Problem 13:
Write a function that takes as input a list of words and upper-cases each word. Use
`functools.map` in some capacity to solve this.
Input : ['aa', 'bb', 'cd', 'e']
Output : ['AA', 'BB', 'CD', 'E']
'''

def uppercase_words(words):
    # Define a function to convert a single word to uppercase
    def to_upper(word):
        return word.upper()

    # Use map to apply the to_upper function to each word in the list
    return list(map(to_upper, words))

def main():
    input_str = input("Enter words separated by spaces: ")  # Get user input for words
    words = input_str.split()  # Split the input string into a list of words

    result = uppercase_words(words)  # Calling the function to uppercase each word
    print(result)  # Output the list of uppercased words

if __name__ == "__main__":
    main()  # Execute the main function
