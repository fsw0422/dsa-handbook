# List

```Python
...

from copy import copy


"""
Allocation
"""
empty_list = list()
list_ = [1, 2, 3]
matrix = [
    [1, 2],
    [3, 4],
    [5, 6],
]

"""
Basic Operations
"""
list_ = [1, 6, 9, 7]
list_.append(3) # TC: Amortized O(1) - [1, 6, 9, 7, 3]
list_.insert(2, 1) # TC: O(N) - [1, 6, 1, 9, 7, 3] (If index is out-of-bounds towards lowest index, it will insert in first index. If index is out-of-bounds towards highest index, it will append to end of list)
list_.remove(1) # TC: O(N) - [6, 1, 9, 7, 3] (If value does not exist, raises 'ValueError')
first = list_[1]  # TC: O(1) - 1

len(list_) # TC: O(1) - 3
min(list_) # TC: O(N) - 9 (We mostly care about numbers, as elements in interviews)
max(list_) # TC: O(N) - 1 (We mostly care about numbers, as elements in interviews)

if 1 in list_: # TC: O(N)
    ...
for e in list_:
    ...

"""
Range

'range(..)' is an immutable sequence object (not an iterable)
It also doesn't create the materialized sequence beforehand (memory-efficient)
"""
range_from_zero_to_end = range(5) # 0, 1, 2, 3, 4
range_from_start_to_end = range(2, 5) # 2, 3, 4
range_from_start_to_end_by_skip = range(2, 5, 2) # 2, 4
list(range(100)) # [0, 1, 2, ... , 99] ('range' object is materialized only when wrapped with list)

"""
Copy
"""
list_ = [1, 2, 3, 4]
copied_list = copy(list_)

"""
Reverse
"""
list_ = [1, 2, 3]
reversed_ = reversed(list_) # TC: O(1) - 3, 2, 1
list_.reverse() # TC: O(N) - [3, 2, 1] (In-place)

"""
Slicing
"""
list_ = [0, 1, 2, 3, 4, 5, 6, 7]
empty_sliced = list_[2:2] # []
range_sliced = list_[2:4] # [2, 4]
inverted_sliced = list_[-3:-1] # [5, 6] (Same as slice_target_list[len(slice_target_list)-3:len(slice_target_list)-1])
skipped_sliced = list_[1:5:2] # [1, 3] (Skip by 2 inclusive from the start index)
reverse_sliced = list_[5:1:-2] # [5, 3, 1] (Skip by -2 inclusive from the start index reverse)
rotated = list_[2:] + list_[:2] # [2, 3, 4, 5, 6, 7, 0, 1] (Rotates slice_target_list by '2' to the left)

"""
List Comprehension and Tricks
"""
init_1d_list = [0 for _ in range(2)] # [0, 0]
init_2d_matrix = [[0 for _ in range(2)] for _ in range(2)] # [[0, 0], [0, 0]] (DO NOT USE [0] * 2 since all rows have same pointer. This means single row modification will affect all rows)
filtered = [x for x in range(0, 3) if x % 2 == 0] # [0, 2]
flattened = [item for sublist in [[1, 2], [3, 4]] for item in sublist] # [1, 2, 3, 4]

"""
Others
"""
tuple([1, 2, 3]) # (1, 2, 3) (You can use 'tuple' as immutable list. All operations that can be applied are identical to a normal 'list')
zip([1, 2, 3], ['zebra', 'tiger', 'giraffe']) # TC: O(1) - (1, 'zebra'), (2, 'tiger'), (3, 'giraffe') (You can also feed an iterator instead of a list as parameter)
enumerate([1, 2, 3]) # TC: O(1) - (0, 1), (1, 2), (2, 3) (Useful when you need to map value -> index. You can also feed an iterator instead of a list as parameter)

"""
In interviews, there are rarely cases where you will need to define a custom class over primary type
However just in case you need to, here is an example of a 'Contact' class
"""
class Contact:

    def __init__(self, name: str, age: int):
        self.name = name
        self.age = age

    def __hash__(self) -> int:
        # Hash function that is used for data structures like 'set' / 'dict' to determine the equality
        return hash((self.name, self.age))

    def __eq__(self, other: 'Contact') -> bool: # When self-referencing class within class, it should be double-quoted
        # Used when '==' or 'sort()'
        return self.name == other.name and self.age == other.age

    def __lt__(self, other: 'Contact') -> bool:
        # Used when '<' or '>' or 'sort()'
        return (self.name, self.age) < (other.name, other.age)

    def __repr__(self) -> str:
        return f'Contact(name={self.name}, age={self.age})'
```

# String

```Python
...

"""
Allocation
"""
empty_str = str()
plain_str = 'hello'
repeated_str = 'a' * 5 # "aaaaa"

"""
Basic Operations
"""
str_ = 'hello'
if 'abc' in str_: # TC: O(N)
    ...
for ch in str_:
    ...

"""
Editing

Strings are immutable, therefore it needs to be converted to list for efficient editing (and if needed converted back to string)
Note that `concat = string1 + string2` is an expensive operation as it copies both strings to a new string
"""
char_list = list('hello') # ['h', 'e', 'l', 'l', 'o']
''.join(char_list) # 'hello'

"""
Slicing
"""
# All slicing operations in list are possible in string as well

"""
Prefix / Suffix match
"""
str_ = 'PrefixWordSuffix'
str_.startswith('Prefix') # TC: O(P) - True
str_.endswith('Suffix') # TC: O(S) - True

"""
Stringify
"""
str(0.2) # '0.2'
str(1) # '1'
str([1, 2, 3]) # '123'

"""
Others
"""
tuple('hello') # ('h', 'e', 'l', 'l', 'o') (If you need to, you can use tuple as immutable list. All operations that can be applied are identical to a normal 'list')
ord('a') # 97 (Converts character into unique integer. This is mostly useful when you want to further optimize time/space complexity from using Dictionaries (for example character counts), if you know that you are only dealing with English characters)

"""
Utility Operations for input sanitization or debug output
"""
'   hello '.strip() # 'hello'
'AbCde'.lower() # 'abcde'

str_list = 'hello,how,are,you'.split(',') # ['hello', 'how', 'are', 'you']
','.join(str_list) # 'hello,how,are,you'

name, rank = 'Eminem', 3
f'Name: {name}, Rank: {rank}' # 'Name: Eminem, Rank: 3'
```
