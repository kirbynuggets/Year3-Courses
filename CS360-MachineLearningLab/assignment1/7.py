"""Write a python program
i. Given a dictionary person = { 'first_name': 'John','last_name': 'Doe','age': 25,'favorite_colors': ['blue', 'green'],'active': True}. Print the dictionary.
ii. Print the keys and values of the dictionary separately.
iii. Print the value for the 2nd key"""
    
person = {
    'first_name': 'John',
    'last_name': 'Doe',
    'age': 25,
    'favorite_colors': ['blue', 'green'],
    'active': True
}

print("i. Dictionary:", person)

print("ii. Keys:", person.keys())
print("Values:", person.values())

keys_list = list(person.keys())
second_key = keys_list[1]
print("iii. Value for 2nd key:", person[second_key])
