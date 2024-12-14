'''
Problem 12:
Write a `class` such that:
1. The initializer takes an arbitrary list of atomic values as input and saves it in an
   instance variable.
2. Has a method called `apply` which has the following functionality:
   1. Accepts a function as a parameter. You can use a lambda function.
   2. Applies the function to the saved list and returns the output. The instance variable
      must not be modified.
   3. If it fails, raise an `Exception` with a custom error message. You can use `try` and
      `except` here.
'''

class ListProcessor:
    def __init__(self, values):
        self.values = values  # saving the list of atomic values

    def apply(self, func):
        try:
            return func(self.values)  # applying function and returning the result
        except Exception as e:
            raise Exception(f"An error occurred while applying the function: {e}")  # raising custom error

def main():
    processor = ListProcessor([1, 2, 3, 4, 5])  # creating ListProcessor instance

    result = processor.apply(lambda x: [i * i for i in x])  # calling function to get squares
    print(result)  # Output: [1, 4, 9, 16, 25]

    result = processor.apply(lambda x: [i for i in x if i > 3])  # calling function to get elements > 3
    print(result)  # Output: [4, 5]

if __name__ == "__main__":
    main()  # executing main function
