# List

```Python
...

"""
Allocation
"""
list() # Returns: []
tuple([1, 2, 3]) # Returns: (1, 2, 3) => Immutable version of 'list'
[1, 2, 3]
[
    [1, 2],
    [3, 4],
    [5, 6],
]

"""
Basic Operations

Reserve generic variable / parameter names with '{val}s' or '{val}es' appended (plural)
Apply this even if it's grammatically incorrect i.e.) children (x) -> childs (O)
"""
nums = [1, 6, 9, 7]
nums.append(3) # TC: Amortized O(1) - State: [1, 6, 9, 7, 3]
nums.insert(2, 1) # TC: O(N) - State: [1, 6, 1, 9, 7, 3] => If index is out-of-bounds towards lowest index, it will insert in first index. If index is out-of-bounds towards highest index, it will append to the end
nums.remove(1) # TC: O(N) - State: [6, 1, 9, 7, 3] => If value does not exist, raises 'ValueError'
nums[2]  # TC: O(1) - Returns: 9
nums[-1]  # TC: O(1) - Returns: 3

len(nums) # TC: O(1) - Returns: 3
min(nums) # TC: O(N) - Returns: 9 => We mostly care about numbers, as elements in interviews
max(nums) # TC: O(N) - Returns: 1 => We mostly care about numbers, as elements in interviews

if 1 in nums: # TC: O(N)
    ...
for num in nums:
    ...

"""
Range

'range(..)' returns an immutable sequence object ('range'), which is also iterable
It also doesn't create the materialized sequence beforehand (memory-efficient)
"""
range(5) # Returns: range(0, 5) => Sequence yields 0, 1, 2, 3, 4
range(2, 5) # Returns: range(2, 5) => Sequence yields 2, 3, 4
range(2, 5, 2) # Returns: range(2, 5, 2) => Sequence yields 2, 4
range(5) # Returns: range(0, 5) => 'range' object over 0, 1, 2, 3, 4
range(2, 5) # Returns: range(2, 5) => 'range' object over 2, 3, 4
range(2, 5, 2) # Returns: range(2, 5, 2) => 'range' object over 2, 4
list(range(100)) # Returns: [0, 1, 2, ... , 99] => 'range' object is materialized only when wrapped with 'list'

"""
Copy
"""
copy.copy([1, 2, 3, 4])

"""
Reverse
"""
nums = [1, 2, 3]
reversed(nums) # TC: O(1) - Returns: list_reverseiterator object => Yields 3, 2, 1
nums.reverse() # TC: O(N) - State: [3, 2, 1] => *In-place*

"""
Slicing
"""
nums = [0, 1, 2, 3, 4, 5, 6, 7]
nums[2:2] # Returns: []
nums[2:4] # Returns: [2, 4]
nums[-3:-1] # Returns: [5, 6] => Same as `nums[len(nums)-3:len(nums)-1]`
nums[1:5:2] # Returns: [1, 3] => Skip by 2 inclusive from the start index
nums[5:1:-2] # Returns: [5, 3, 1] => Skip by -2 inclusive from the start index reverse
nums[2:] + nums[:2] # Returns: [2, 3, 4, 5, 6, 7, 0, 1] => Rotates `nums` by '2' to the left

"""
List Comprehension and Tricks
"""
[0 for _ in range(2)] # Returns: [0, 0]
[[0 for _ in range(2)] for _ in range(2)] # Returns: [[0, 0], [0, 0]] => **DO NOT USE** [0] * 2 since all rows have same pointer. This means single row modification will affect all rows
[x for x in range(0, 3) if x % 2 == 0] # Returns: [0, 2]
[num for nums in [[1, 2], [3, 4]] for num in nums] # Returns: [1, 2, 3, 4]

"""
Others
"""
tuple([1, 2, 3]) # Returns: (1, 2, 3) => You can use 'tuple' as immutable list. All operations that can be applied are identical to a normal 'list'
zip([1, 2, 3], ['zebra', 'tiger', 'giraffe']) # TC: O(1) - Returns: zip object => Yields (1, 'zebra'), (2, 'tiger'), (3, 'giraffe'). You can also feed any 'Iterable' instead of a 'list' as parameter
enumerate([1, 2, 3]) # TC: O(1) - Returns: enumerate object => Yields (0, 1), (1, 2), (2, 3). Useful when you need to map value -> index. You can also feed any 'Iterable' type instead of a 'list' type as parameter
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

Reserve generic variable / parameter names with 'txt'
"""
txt = 'hello'
if 'abc' in txt: # TC: O(N)
    ...
for ch in txt:
    ...

"""
Editing

'str's are immutable, therefore it needs to be converted to list for efficient editing (and if needed converted back to string)
Note that operations like `'text1' + 'text2'` is an expensive operation as it copies both strings to a new string
"""
chs = list('hello') # Returns: ['h', 'e', 'l', 'l', 'o']
''.join(chs) # Returns: 'hello'

"""
Slicing
"""
# All slicing operations in list are possible in string as well

"""
Prefix / Suffix match
"""
txt = 'PrefixWordSuffix'
txt.startswith('Prefix') # TC: O(P) - Returns: True
txt.endswith('Suffix') # TC: O(S) - Returns: True

"""
Stringify
"""
str(1) # Returns: '1'
str(0.2) # Returns: '0.2'
str([1, 2, 3]) # Returns: '123'

"""
Numberify
"""
int('23') # Returns: 23 => int
float('3.14') # Returns: 3.14 => float

"""
Others
"""
ord('a') # Returns: 97 => Converts character into unique integer. This is mostly useful when you want to further optimize time/space complexity from using Dictionaries (for example character counts), if you know that you are only dealing with English characters

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
