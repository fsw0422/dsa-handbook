## Coding Tips

- Try to make variable names as short as possible (but readable) as it's repetitive to type the whole variable every time, especially if you don't have autocompletion during interviews.

  ```python
  ...
  
  # Clearly readable and concise when shortened
  result = ... # (X)
  res = ... # (O)
  
  stack = ... # (X)
  stk = ... # (O)
  
  queue = ... # (X)
  que = ... # (O)
  
  graph = ... # (X)
  gph = ... # (O)
  
  # When shortened and not readable, just use entire word
  s # (X)
  st # (X)
  stt # (X)
  start # (O)
  
  # If it makes sense in context, it's generally ok
  s, e = ... # start / end
  l, r =  ... # left / right
  lo, hi = ... # low / high
  ```
- For 'list', 'string', 'set', 'dict', 'Tuple', unless the context naturally guides you to name your variables / parameters in a certain way, use generic reserved names (under 'Basic Operations' in every chapter).
  It's designed to be concise, and not clash with built-in functions or keywords.

  ```python
  ...
  
  from typing import List
  
  """
  Uses names in function context
  """
  def compare_marked_words(wrds: List[str]):
      seen = ...
  
  """
  Uses generic reserved names
  """
  def compare_unique_strings(txt: str):
      utxts = ...
  ```
- Always use *single quote* (') over *double quote* (") as pressing the Shift key every time is repetitive.

  ```python
  ...
  
  "string" # (X)
  'string' # (O)
  ```
- Although not preferred, but if two or more words are unavoidable for readability (like adjectives or 2 variables with same type), use snake case to concatenate them.

  ```python
  ...
  
  awesome_num = 3
  ```
- Avoid keywords for single-word variables.
  
  ```python
  ...
  
  str = str() # (X)
  txt = str() # (O)
  ```
- Don't use function parameters as mutable working variables; keep parameters as inputs and assign transformed values to new local variables.

  ```python
  ...
  
  def increment(num: int):
      num += 1 # (X)
      nnum = num + 1 # (O)
  ```
- Group related variable assignments in a single line when they belong to the same context (e.g., pointers, bounds, counters).

  ```python
  ...

  l, r = 0, 0
  lo, hi = 0, len(nums) - 1
  i, j = 0, n - 1
  ```
- Rather than Enums, use constants to save time

  ```python
  ...
  
  from enum import Enum
  
  rng = range(10)
  
  """
  Not recommended as it needs a lot more coding
  """
  class Interval(Enum):
      START, END = 0, 1
  rng[Interval.START.value]
  rng[Interval.END.value]
  
  """
  Recommended as it's simpler
  """
  START, END = 0, 1
  rng[START]
  rng[END]
  ```
- When a nested function has the same name as the outer function, prepend '\_'.

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
- In interviews, there are rarely cases where you will need to define a custom class (with operand overrides) over primitive types for the encapsulation of data group.
  However, just in case you need to, here is an example of a 'Contact' class.

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
