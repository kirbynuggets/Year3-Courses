"""Write a Python function that takes a list and returns a new list with unique elements
of the first list"""

def get_unique_elements(list1):
    return list(set(list1))

list1 = [1, 2, 2, 3, 3, 4, 4, 5]
unique_list = get_unique_elements(list1)
print("Unique Elements:", unique_list)
