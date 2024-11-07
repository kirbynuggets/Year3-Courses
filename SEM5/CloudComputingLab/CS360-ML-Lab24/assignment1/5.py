'''Write a program to merge two lists and display it as a single list.Print the even numbers
from the final list'''

list1 = [1, 2, 3, 4]
list2 = [5, 6, 7]

merged_list = list1 + list2

print(merged_list[:])

even_elements = [num for num in merged_list if num%2 == 0]
print("Even numbers: ", even_elements)