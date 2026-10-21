# Set

Sets store unique, hashable elements, and their iteration order is not guaranteed.
For sets and dictionaries, O(1) hash-table operations are average-case bounds that assume constant-time hashing and equality checks.
Insertions are also amortized over resizing; individual operations can take O(N) in the worst case.

```python
...

from typing import Set, FrozenSet


"""
Allocation
"""
nums: Set[int] = set() # Returns: set() => Use set() for an empty set; {} creates an empty dictionary
ro_nums: FrozenSet[int] = frozenset([1, 2, 3]) # Returns: frozenset({1, 2, 3}) => Immutable version of 'set'
{1, 2, 3}

"""
Basic Operations

You can use 'uq_' to indicate unique elements, such as 'uq_nums', and 'ro_' for read-only or immutable collections, such as 'ro_nums'.
These prefixes are optional; a simpler name such as 'nums' is sufficient when its meaning is clear and it does not overlap with another name in the same scope.
"""
nums = {1, 5, 3, 2}
nums.add(1) # TC: O(1) - State: {1, 5, 3, 2}
nums.remove(1) # TC: O(1) - State: {5, 3, 2} => Raises 'KeyError' if the value does not exist
nums.discard(1) # TC: O(1) - State: {5, 3, 2} => Does not raise 'KeyError' if the value does not exist
set([3, 2, 1, 3, 5]) # Returns: {1, 2, 3, 5} => Removes duplicates; the displayed order is not guaranteed

len(nums) # TC: O(1) - Returns: 3
min(nums) # TC: O(N) - Returns: 2 => Raises 'ValueError' for an empty set
max(nums) # TC: O(N) - Returns: 5 => Raises 'ValueError' for an empty set

if 1 in nums: # TC: O(1)
    ...
for num in nums:
    ...
```

# Dictionary

Dictionary keys must be hashable; values need not be.
Dictionaries preserve insertion order.

```python
...

from collections import defaultdict, Counter
from types import MappingProxyType
from typing import Dict, DefaultDict, Mapping


"""
Allocation
"""

name_to_count: Dict[str, int] = dict() # Returns: {}
name_to_count = {'birds': 1, 'mammals': 2, 'reptiles': 1}
dd_name_to_count: DefaultDict[str, int] = defaultdict(int) # Accessing a missing key with d[key] inserts 0. Other factory defaults: float -> 0.0, bool -> False, str -> '', list -> [], set -> set(), dict -> {}
dd_name_to_count['birds'] # Returns: 0 => Inserts 'birds' with a default count
dd_name_to_count.get('mammals') # Returns: None => Unlike d[key], get() does not insert a missing key
ro_name_to_count: Mapping[str, int] = MappingProxyType(name_to_count) # Returns: mappingproxy({'birds': 1, 'mammals': 2, 'reptiles': 1}) => A read-only view, not an immutable copy
name_to_count['birds'] = 2
ro_name_to_count['birds'] # Returns: 2 => Reflects changes to the underlying dictionary

"""
Basic Operations

Use '{key}_to_{val}' for dictionary variable and parameter names, such as 'name_to_age'.
Use '{field1}_{field2}' for tuple pairs, such as 'name_age', and plural names such as 'name_age_pars' for collections of pairs.
Add 'dd_' for defaultdicts and 'ro_' for read-only mappings only to distinguish coexisting variants.
For example, 'name_to_count', 'dd_name_to_count', and 'ro_name_to_count' distinguish the three mapping objects in the allocation examples.

Dictionary construction accepts an iterable of key-value pairs; the pairs themselves need not be hashable.
A tuple can be a dictionary key only if all its elements are hashable.
"""
name_to_age = {'John': 23, 'Amy': 32, 'George': 43}
name_to_age['John'] # TC: O(1) - Returns: 23
name_to_age.pop('Amy') # TC: O(1) - Returns: 32, State: {'John': 23, 'George': 43} => Removes the key and returns its value. Raises 'KeyError' if the key does not exist
name_to_age.pop('Adam', 0) # TC: O(1) - Returns: 0, State: {'John': 23, 'George': 43} => Returns the default value if the key does not exist
list(name_to_age) # Returns: ['John', 'George']
name_age_pars = list(name_to_age.items()) # Returns: [('John', 23), ('George', 43)]
dict(name_age_pars) # Returns: {'John': 23, 'George': 43} => Builds a dictionary from key-value pairs

"""
Dictionary Views

keys(), values(), and items() return dynamic views rather than copies.
Views reflect later changes to the dictionary, but they do not support indexing like a list.
Keys views support set operations; items views can be used as sets of pairs when their values are also hashable.
Values views are neither lists nor sets.
Use '_itms' for items-view variable names, such as 'name_age_itms'.
"""
names = name_to_age.keys()
if 'John' in name_to_age: # TC: O(1)
    ...
for name in name_to_age:
    ...
if 'John' in names: # TC: O(1)
    ...
for name in names:
    ...

ages = name_to_age.values()
if 2 in ages: # TC: O(N)
    ...
for age in ages:
    ...

name_age_itms = name_to_age.items()
if ('John', 23) in name_age_itms: # TC: O(1) => Looks up the key and compares its value
    ...
for name, age in name_age_itms:
    ...

"""
Dictionary Comprehension

Use items() to iterate over key-value pairs when inverting a dictionary.
The original values become keys, so they must be hashable.
If multiple original keys share a value, later entries overwrite earlier ones in the inverted dictionary.
"""
{v: k for k, v in {1: 'a', 2: 'b', 3: 'c'}.items()} # Returns: {'a': 1, 'b': 2, 'c': 3}

"""
Counters

Counter is a dictionary subclass for counting hashable objects.
It reduces boilerplate compared with a normal dict or defaultdict.
Reading a missing key returns 0 without inserting the key.
"""
Counter(['banana', 'orange', 'apple', 'apple']) # Returns: Counter({'apple': 2, 'banana': 1, 'orange': 1})
ch_to_count = Counter('hello') # Returns: Counter({'l': 2, 'h': 1, 'e': 1, 'o': 1})
ch_to_count['z'] # Returns: 0 => Does not insert 'z'
```

Make sure you understand how sets and dictionaries work internally.
- [LeetCode 705. Design HashSet](https://leetcode.com/problems/design-hashset)
- [LeetCode 706. Design HashMap](https://leetcode.com/problems/design-hashmap)

Sets and dictionaries often support other data structures by providing efficient membership tests and lookups.
Common interview examples combine them with lists and strings.
- [LeetCode 1. Two Sum](https://leetcode.com/problems/two-sum)
- [LeetCode 242. Valid Anagram](https://leetcode.com/problems/valid-anagram)

Sets and dictionaries are also used to represent graphs and track visited nodes.
Graphs are covered in a later chapter.
