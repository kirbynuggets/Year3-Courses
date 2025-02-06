"""Write a python program 
i. Create a tuple of mixed data type and print it.
ii. Create a tuple with the repetition of the words “programming” 3 times.
iii. Create two tuples and concatenate both the tuples.
"""
mixed_tuple = (1, 'hello', 3.14, True)
print("Mixed Tuple:", mixed_tuple)

repeated_tuple = ('programming',) * 3
print("Repeated Tuple:", repeated_tuple)

tuple1 = (1, 2, 3)
tuple2 = (4, 5, 6)
concatenated_tuple = tuple1 + tuple2
print("Concatenated Tuple:", concatenated_tuple)
