'''Write a python program to swap the value of two variables without using a temporary
variable and with using a temporary variable.'''

def swapWvar(a,b):
    c = b
    b = a
    a = c

    print(a , b)

def swapWOvar(a,b):
    a += b
    b = a - b
    a -= b

    print(a, b)

def main():
    a = 3
    b = 7
    while True:
        print("Choose")
        print("i. Swap without temp. variable: ")
        print("ii. Swap with temp. variable: ")
        print("iii. Exit")

        choice = input("Enter the choice i, ii, iii: ")

        if choice == 'i':
            swapWvar(a,b)

        elif choice == 'ii':
            swapWOvar(a,b)

        elif choice == 'iii':
            print("Exiting the program...")
            break

        else:
            print("Invalid choice, type i, ii ,iii only")

if __name__ == "__main__":
    main()