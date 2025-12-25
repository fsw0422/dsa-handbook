## Coding Tips

- Below are frequently used variable name pools.
  ```python
  ...
  
  seen # Replacement of 'visited' (set)
  deq, que, stk # 'deque' / 'queue' / 'stack'
  num, nums # 'number(s)'
  str_, strs # 'string(s)'
  ch, chs # 'character(s)'
  nbr, nbrs # 'neighbour(s)'. Used in Graphs
  src, dst # 'source' / 'destination'. Used in Graphs
  i, j, k # Generic indexes
  lo, mid, piv, hi # 'low' / 'middle' / 'high / 'pivot' (3 pointers but handling lower / middle / higher half of the list and pivot when custom sorting)
  cur, prv, nxt # 'current' / 'previous' / 'next' (3 pointers advancing) 
  row, col # 'row' / 'column' 
  memo, dp # 'memoization'(top-down) 'dynamic programming' (bottom-up)
  val # 'value'
  lvl # 'level
  amt # 'amount'
  targ # 'target'
  cnt # 'count'
  res # 'result'
  rem # 'remaining'
  ```
- Always use single quote (') than double quotes (") as it's repetitive to press the shift key everytime for double quotes.
  ```python
  ...
  
  'string' # (O)
  "string" # (X)
  ```
- If two or more words are unavoidable (like adjectives or 2 variables with same type), use snake case to concatenate them.
  ```python
  ...
  
  awesome_num = 3
  ```
- Avoid keywords for single-word variables.
  If you need to use them, please append '_'.
  Of course this doesn't apply for 2-or-more-words variables.
  
  ```python
  ...
  
  str_ = str()
  max_ = max([1, 2, 3])
  min_ = min([1, 2, 3])
  sum_ = sum([1, 2, 3])
  len_ = len([1, 2, 3])
  ```
- Some words are easily readable when read-out-loud compressed. 
  If so, use it.
  However, some aren't.
  In this case, just use the entire word.
  ```python
  ...
  
  comp = 2 # 'complement' (easily readable)
  carry = 3 # 'crry' (not easily readable. Even just removing all vowels from 'carry' doesn't help)
  ```
- For Dictionaries, try using 'a_to_b' (except for counters).
  ```python
  ...
  
  from collections import Counter
  
  val_to_i = { 'val': 1 } 
  str_counter = Counter('abcd')
  chs_counter = Counter(['a', 'b', 'c', 'd'])
  ```
- Rather than Enums, use constants to save time
  ```python
  ...
  
  from enum import Enum
  
  interval = range(10)
  
  """
  Not recommended as it needs alot more coding
  """
  class Interval(Enum):
      START, END = 0, 1
  interval[Interval.START.value]
  interval[Interval.END.value]
  
  """
  Recommended as it's simpler
  """
  START, END = 0, 1
  interval[START]
  interval[END]
  ```
- When nested function has clashing name as the outer function, prepend '\_'.
  Of course if it make sense to compress it, please do so as the '\_' is not needed then.
  ```python
  ...
  
  def func1(num: int):
      def func2(_num: int):
          ...
  ```
  - Use single-line swap, as it removes the need to introduce another variable.
    
  ```python
  ...
  
  a, b = b, a
  ```
- In interviews, there are rarely cases where you will need to define a custom class (with operand overrides) over primary type for the encapsulation of data group.
  However just in case you need to, here is an example of a 'Contact' class.

  ```python
  ...

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