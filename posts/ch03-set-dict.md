# Set

```python
...

"""
Allocation
"""
empty_set = set()
set_ = {1, 2, 3}

"""
Basic Operations
"""
set_ = {1, 5, 3, 2}
set_.add(1) # TC: O(1) - {1, 5, 3, 2}
set_.remove(1) # TC: O(1) - {5, 3, 2} (Raises 'KeyError' if value does not exist)
set_.discard(1) # TC: O(1) - {5, 3, 2} (Does not raise 'KeyError' if value does not exist)
set_converted_list = set([3, 2, 1, 3, 5]) # {3, 2, 1, 5} (Removes duplicate)

len(set_) # TC: O(1)
min(set_) # TC: O(N) (We mostly care about numbers, as element in interviews)
max(set_) # TC: O(N) (We mostly care about numbers, as element in interviews)

if 1 in set_: # TC: O(1)
    ...
for val in set_:
    ...
```

# Dictionary

```python
...

from collections import defaultdict, Counter


"""
Allocation
"""
empty_dict = dict()
dict_ = {'birds': 1, 'mammals': 2, 'reptiles': 1}
default_dict = defaultdict(int) # If accessed like `d[n]`, it will automatically initialize the value with default value depending on the type (`int`: 0, `float`: 0.0, `bool`: False, `str`: "", `list`: [], `set`: {}, `dict`: {})

"""
Basic Operations
"""
dict_ = {'John': 23, 'Amy': 32, 'George': 43}
tuple_list = list(dict_) # [('John', 23), ('Amy', 32), ('George', 43)]
dict_ = dict(tuple_list) # {'John': 23, 'Amy': 32, 'George': 43} (Tuples can be converted to 'map' easily. This is due to the fact that tuple itself is an immutable data model which implements hash and equal methods. It's also useful when the tuple object is to be shared with another datastructure. For example, the same tuple can be used in a heap but also be indexed in `dict` for fast lookup. Typing of tuple is `Tuple[Any, ...]`)
john_age = dict_['John'] # TC: O(1) - 2
dict_.pop('Amy') # TC: O(1) - 23, {'John': 23, 'George': 43} (Removes key and returns value. Raises 'KeyError' if key does not exist)
dict_.pop('Adam', 0) # TC: O(1) - 0, {'John': 23, 'George': 43} (Removes key and returns value. Returns default value if key does not exist)

# Each returns its own immutable class object (it can't be indexed with 'enumerate(..)')
keys = dict_.keys()
if 'John' in dict_: # TC: O(1)
    ...
for key in dict_:
    ...
if 'John' in keys(): # TC: O(1)
    ...
for key in keys():
    ...

vals = dict_.values()
if 2 in vals: # TC: O(N)
    ...
for val in vals:
    ...

items = dict_.items()
if ('John', 23) in items: # TC: O(N)
    ...
for key, val in items:
    ...

"""
Dictionary Comprehension
"""
key_val_swapped_dict = {val: key for key, val in {1: 'a', 2: 'b', 3: 'c'}} # {'a': 1, 'b': 2, 'c': 3} 

"""
Counters

It's a convenience collection to count items. It can remove alot of boilerplate code than using normal `dict` or `defaultdict`
"""
Counter(['banana', 'orange', 'apple', 'apple']) # {'banana': 1, 'orange': 1, 'apple': 2}
Counter('hello') # {'h': 1, 'e': 1, 'l': 2, 'o': 1}
```

- Make sure you understand how Set / Dictionary works internally.

    [LeetCode 705. Design HashSet](https://leetcode.com/problems/design-hashset)

    [LeetCode 706. Design HashMap](https://leetcode.com/problems/design-hashmap)

- Set / Dictionary often comes as supporting data structure of a main data structure for optimization purpose (mostly for List / String in interviews).

    [LeetCode 1. Two Sum](https://leetcode.com/problems/two-sum)

    [LeetCode 125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome)

- Set / Dictionary is used to represent Graphs (covered later) and mark visited nodes
