## Coding Tips

- Try to make variable names as short as possible without harming readability too much.
  It's repetitive to type the whole variable every time, especially if you don't have autocompletion during interviews.

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
  
  # If variables are in pair, it's generally ok to shorten as context itself is self-explanatory
  # start / end
  s = ...
  e = ...

  # left / right
  l = ...
  r = ...

  # low / high
  lo = ...
  hi = ...
  ```
- For method names, if it's a helper function (like recursive function), make it concise as possible.
  However if it's the function name for the main solution itself, be as verbose as possible.

  ```python
  ...

  # Main function — verbose and descriptive
  def my_great_solution(nums: List[int]) -> int:

      # Helper function — simple and concise
      def rec(i):
          ...
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
      new_num = num + 1 # (O)
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
      START = 0
      END = 1
  rng[Interval.START.value]
  rng[Interval.END.value]
  
  """
  Recommended as it's simpler
  """
  START = 0
  END = 1
  rng[START]
  rng[END]
  ```
- When a nested function parameter has the same name as an outer function parameter, prepend '\_'.

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
- In interviews, there are rare cases where you will need to define a custom class over primitive types with tuples to encapsulate a certain data group.
  However, if the data model grows, `@dataclass` will do the job.
  
  ```python
  ...

  from dataclasses import dataclass


  @dataclass(frozen=True, order=True)
  class Contact:
      name: str
      age: int
  ```
- Use `nonlocal` in a nested function to rebind a variable from the enclosing (non-global) scope.
  Without it, assigning to an outer variable inside an inner function creates a new local variable instead.

  ```python
  ...

  """
  Typical use case: accumulating state across recursive/nested calls without a mutable container
  Often when the outside variable is a mutalbe object like 'list', you don't need to rebind them
  """
  def count_good_nodes(rt: TreeNode) -> int:
      res = 0

      def traverse(nd: TreeNode, max_val: int):
          nonlocal res

          if not nd:
              return
          if nd.val >= max_val:
              res += 1

          traverse(nd.left, max(max_val, nd.val))
          traverse(nd.right, max(max_val, nd.val))

      traverse(rt, -math.inf)
      return res
  ```
