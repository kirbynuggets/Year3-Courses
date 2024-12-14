"""Write a python program -
i. Assign any value to a variable and print the value and its type.
ii. Assign values to two variables and perform the following operations
(addition,subtraction, multiplication,division).
iii. Assign any string to a variable and print the length of the string.
iv. Assign a value as string to a variable and then change the type of that variable to integer."""

def valType():
    a = "15"
    print("Type of 'a':", type(a))

def operations():
    a = 5
    b = 7

    print("Addition:", a + b)
    print("Subtraction:", a - b)
    print("Multiplication:", a * b)
    print("Division:", a / b)

def strLength():
    string = "Hello, I am a girl"
    print("Length of string:", len(string))

def typeConversion():
    a = "123"
    print("Type of 'a' before conversion:", type(a))
    a = int(a)
    print("Type of 'a' after conversion:", type(a))

def main():
    while True:
        print("\nChoose an option:")
        print("i. Check type of a variable")
        print("ii. Perform arithmetic operations")
        print("iii. Find length of a string")
        print("iv. Type conversion")
        print("v. Exit")

        choice = input("Enter your choice (i, ii, iii, iv, v): ")

        if choice == 'i':
            valType()
        elif choice == 'ii':
            operations()
        elif choice == 'iii':
            strLength()
        elif choice == 'iv':
            typeConversion()
        elif choice == 'v':
            print("Exiting the program.")
            break
        else:
            print("Invalid choice. Please select i, ii, iii, iv, or v.")

if __name__ == "__main__":
    main()
