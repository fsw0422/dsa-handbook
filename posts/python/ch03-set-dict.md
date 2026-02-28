# Set

```python
...

"""
Allocation
"""
set() # Returns: {}
frozenset([1, 2, 3]) # Returns: frozenset({1, 2, 3}) => Immutable version of 'set'
{1, 2, 3}

"""
Basic Operations

reserve generic variable / parameter names with 'u{val}s' (prepending 'u' for uniqueness)
"""
unums = {1, 5, 3, 2}
unums.add(1) # TC: O(1) - State: {1, 5, 3, 2}
unums.remove(1) # TC: O(1) - State: {5, 3, 2} => Raises 'KeyError' if value does not exist
unums.discard(1) # TC: O(1) - State: {5, 3, 2} => Does not raise 'KeyError' if value does not exist
set([3, 2, 1, 3, 5]) # Returns: {3, 2, 1, 5} => Removes duplicate

len(unums) # TC: O(1)
min(unums) # TC: O(N) => We mostly care about numbers, as element in interviews
max(unums) # TC: O(N) => We mostly care about numbers, as element in interviews

if 1 in unums: # TC: O(1)
    ...
for unum in unums:
    ...
```

# Dictionary

```python
...

from collections import defaultdict, Counter
from types import MappingProxyType


"""
Allocation
"""
dict() # Returns: {}
{'birds': 1, 'mammals': 2, 'reptiles': 1}
MappingProxyType({'birds': 1, 'mammals': 2, 'reptiles': 1}) # Returns: mappingproxy({'birds': 1, 'mammals': 2, 'reptiles': 1}) => Immutable version of 'dict'
defaultdict(int) # If accessed like `d[n]`, it will automatically initialize the value with default value depending on the type (`int`: 0, `float`: 0.0, `bool`: False, `str`: "", `list`: [], `set`: {}, `dict`: {})

"""
Basic Operations

Reserve generic variable / parameter names with
- '{key}_to_{val}' for 'dict's
- '{key}_{val}_tup' for 'tuple's
"""
name_to_age = {'John': 23, 'Amy': 32, 'George': 43}
name_to_age['John'] # TC: O(1) - Returns: 23
name_to_age.pop('Amy') # TC: O(1) - Returns: 23, State: {'John': 23, 'George': 43} => Removes key and returns value. Raises 'KeyError' if key does not exist
name_to_age.pop('Adam', 0) # TC: O(1) - Returns: 0, State: {'John': 23, 'George': 43} => Removes key and returns value. Returns default value if key does not exist
list(name_to_age) # Returns: ['John', 'Amy', 'George']
name_age_tups = list(name_to_age.items()) # Returns: [('John', 23), ('Amy', 32), ('George', 43)]
dict(name_age_tups) # Returns: {'John': 23, 'Amy': 32, 'George': 43} => Tuples can be converted to 'map' easily. This is due to the fact that tuple itself is an immutable data model which implements hash and equal methods. It's also useful when the tuple object is to be shared with another datastructure. For example, the same tuple can be used in a heap but also be indexed in `dict` for fast lookup. Typing of tuple is `Tuple[Any, ...]`

# Each returns its own dynamic view object ('dict_keys', 'dict_values', 'dict_items')
# However, we'll share the same variable names between
# - `dict_keys` <-> `set`
# - `dict_values` <-> 'list'
# - `dict_items` <-> 'tuple'
unames = name_to_age.keys()
if 'John' in name_to_age: # TC: O(1)
    ...
for name in name_to_age:
    ...
if 'John' in unames: # TC: O(1)
    ...
for name in unames:
    ...

ages = name_to_age.values()
if 2 in ages: # TC: O(N)
    ...
for age in ages:
    ...

name_age_tups = name_to_age.items()
if ('John', 23) in itms: # TC: O(N)
    ...
for name, age in name_age_tups:
    ...

"""
Dictionary Comprehension
"""
{v: k for k, v in {1: 'a', 2: 'b', 3: 'c'}} # Returns: {'a': 1, 'b': 2, 'c': 3}

"""
Counters

It's a convenience collection to count items. It can remove a lot of boilerplate code compared with using a normal `dict` or `defaultdict`
"""
Counter(['banana', 'orange', 'apple', 'apple']) # Returns: {'banana': 1, 'orange': 1, 'apple': 2}
Counter('hello') # Returns: {'h': 1, 'e': 1, 'l': 2, 'o': 1}
```

Make sure you understand how Set / Dictionary works internally.
- [LeetCode 705. Design HashSet](https://leetcode.com/problems/design-hashset)
- [LeetCode 706. Design HashMap](https://leetcode.com/problems/design-hashmap)

Set / Dictionary often comes as supporting data structure of a main data structure for optimization purpose (mostly for List / String in interviews).
- [LeetCode 1. Two Sum](https://leetcode.com/problems/two-sum)
- [LeetCode 125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome)

Set / Dictionary is also used to represent Graphs (covered later) and mark visited nodes.
