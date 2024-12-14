'''Write a python programi. Create a list of 6 items and display it.
ii. Print the all elements of the list from 3rd to the end of the list
iii. Insert an element 100 to the middle of the list and also append an element 8 to the end of
the list.
iv. Print the 3rd, 4th and 5th element of the list'''

list1 = ['a','b', 'c', 1, 2, 'okay']

print("i. List display: ", list1[:])
print(f"ii. Elements from 3rd to end: {list1[2:]}")

LenofList = len(list1)//2
list1.insert(LenofList, 100)
list1.insert(len(list1), 8)
print(f"iii. On inserting 100 & 8: {list1[:]}")


print(f"iv. Elements from 3rd, 4th and 5th element: {list1[2:5]}")