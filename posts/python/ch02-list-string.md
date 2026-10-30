# List

```Python
...

import copy
from typing import List, Tuple


"""
Allocation
"""

lst: List[int] = list() # Returns: []
[1, 2, 3]
[
    [1, 2],
    [3, 4],
    [5, 6],
]
ilst: Tuple[int, ...] = tuple([1, 2, 3]) # Returns: (1, 2, 3) => An immutable alternative to a 'list'
name_age: Tuple[str, int] = ('John', 23) # Tuples can represent pairs, triples, and other small groups of values. Use data classes if the data model grows; see Chapter 17 for more information.

"""
Basic Operations

Use clear plural names for collections, such as 'nums', 'names', or 'children'.
"""
nums = [1, 6, 9, 7]
nums.append(3) # TC: Amortized O(1) - State: [1, 6, 9, 7, 3]
nums.insert(2, 1) # TC: O(N) - State: [1, 6, 1, 9, 7, 3] => Inserts at the beginning if the index is below the valid range, or appends at the end if it is above the valid range
nums.remove(1) # TC: O(N) - State: [6, 1, 9, 7, 3] => Raises 'ValueError' if the value does not exist
nums[2]  # TC: O(1) - Returns: 9
nums[-1]  # TC: O(1) - Returns: 3

len(nums) # TC: O(1) - Returns: 5
min(nums) # TC: O(N) - Returns: 1 => Raises 'ValueError' for an empty list
max(nums) # TC: O(N) - Returns: 9 => Raises 'ValueError' for an empty list

if 1 in nums: # TC: O(N)
    ...
for num in nums:
    ...

"""
Range

'range(...)' returns an immutable, iterable 'range' object.
It does not materialize the sequence upfront, which saves memory.
"""
range(5) # Returns: range(0, 5) => 'range' object over 0, 1, 2, 3, 4
range(2, 5) # Returns: range(2, 5) => 'range' object over 2, 3, 4
range(2, 5, 2) # Returns: range(2, 5, 2) => 'range' object over 2, 4
list(range(100)) # Returns: [0, 1, 2, ... , 99] => Wrap the 'range' object in 'list' to materialize the sequence

"""
Copy
"""
copy.copy([1, 2, 3, 4]) # TC: O(N) - Returns: [1, 2, 3, 4] => A shallow copy; nested objects are shared

"""
Reverse
"""
nums = [1, 2, 3]
reversed(nums) # TC: O(1) - Returns: list_reverseiterator object => Yields 3, 2, 1
nums.reverse() # TC: O(N) - State: [3, 2, 1] => Reverses the list *in place*

"""
Slicing

Slices include the start index and exclude the stop index, even with a negative step.
List slicing creates a shallow copy, taking O(K) time and space for K selected elements.
"""
nums = [0, 1, 2, 3, 4, 5, 6, 7]
nums[2:2] # Returns: []
nums[2:4] # Returns: [2, 3]
nums[-3:-1] # Returns: [5, 6] => Same as `nums[len(nums)-3:len(nums)-1]`
nums[1:5:2] # Returns: [1, 3] => Include the start index and step forward by 2
nums[5:1:-2] # Returns: [5, 3] => Include the start index and step backward by 2
nums[2:] + nums[:2] # Returns: [2, 3, 4, 5, 6, 7, 0, 1] => Rotates 'nums' two positions to the left

"""
List Comprehension and Tricks
"""
[0 for _ in range(2)] # Returns: [0, 0]
[0] * 2 # Returns: [0, 0] => Safe for immutable elements such as integers
[[0 for _ in range(2)] for _ in range(2)] # Returns: [[0, 0], [0, 0]] => Each row is a separate list. Avoid [[0] * 2] * 2: it repeats the same inner list, so modifying one row affects every row
[x for x in range(0, 3) if x % 2 == 0] # Returns: [0, 2]
[num for nums in [[1, 2], [3, 4]] for num in nums] # Returns: [1, 2, 3, 4]

"""
Others

Creating a 'zip' or 'enumerate' iterator takes O(1) time; consuming N results takes O(N).
"""
tuple([1, 2, 3]) # Returns: (1, 2, 3) => Tuple items cannot be reassigned, but mutable objects inside a tuple can still change
zip([1, 2, 3], ['zebra', 'tiger', 'giraffe']) # TC: O(1) - Returns: zip object => Yields (1, 'zebra'), (2, 'tiger'), (3, 'giraffe'). Accepts iterables and stops when the shortest input is exhausted
enumerate([1, 2, 3]) # TC: O(1) - Returns: enumerate object => Yields (0, 1), (1, 2), (2, 3). Useful when you need both indices and values. Accepts any iterable as an argument
```

# String

```Python
...

"""
Allocation
"""
str() # Returns: '' => strings are immutable
'hello'
'a' * 5 # Returns: 'aaaaa'

"""
Basic Operations

Use 'txt' as the generic name for string variables and parameters.
"""
txt = 'hello'
if 'abc' in txt: # TC: O(N)
    ...
for ch in txt:
    ...

"""
Editing

Strings are immutable.
For repeated edits to individual characters, convert the string to a list and join it back afterward.
Use the '+' operator to concatenate strings, such as 'hello' + ' world'.
Concatenation generally copies the string contents.
Repeated concatenation in a loop can take quadratic time; collect pieces in a list and use ''.join(pieces) instead.
"""
chs = list('hello') # Returns: ['h', 'e', 'l', 'l', 'o']
''.join(chs) # Returns: 'hello'

"""
Slicing
"""
# Strings support the same slicing operations as lists

"""
Prefix / Suffix match

P is the prefix length; S is the suffix length.
"""
txt = 'PrefixWordSuffix'
txt.startswith('Prefix') # TC: O(P) - Returns: True
txt.endswith('Suffix') # TC: O(S) - Returns: True

"""
Stringify
"""
str(1) # Returns: '1'
str(0.2) # Returns: '0.2'
str([1, 2, 3]) # Returns: '[1, 2, 3]'

"""
Numberify
"""
int('23') # Returns: 23 => int
float('3.14') # Returns: 3.14 => float

"""
Others
"""
ord('a') # Returns: 97 => The character's Unicode code point. With a small, known alphabet, character counts can use list indices instead of dictionary keys

"""
Utility Operations for input sanitization or debug output
"""
'   hello '.strip() # Returns: 'hello'
'AbCde'.lower() # Returns: 'abcde'

txts = 'hello,how,are,you'.split(',') # Returns: ['hello', 'how', 'are', 'you']
','.join(txts) # Returns: 'hello,how,are,you'

name = 'Eminem'
rank = 3
f'Name: {name}, Rank: {rank}' # Returns: 'Name: Eminem, Rank: 3'
```
