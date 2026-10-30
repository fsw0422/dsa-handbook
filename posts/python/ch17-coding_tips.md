# Coding Tips

These conventions keep the handbook's examples concise and consistent.
Choose names that remain clear when explaining the solution.

- Use familiar abbreviations when their meaning is clear.
  Longer names are useful when shortening them would hide their purpose.

  ```python
  from collections import deque


  # Common abbreviations in this handbook.
  res = 0
  stk = []
  que = deque()
  gph = {}

  # Keep names readable when a short form would be ambiguous.
  start = 0
  end = 10

  # Paired indices can use familiar short names.
  r = 0
  c = 1
  lo = 0
  hi = 9
  ```
- Use separate assignment lines for unrelated values.
  Tuple unpacking and simultaneous assignments are useful for related values and swaps.

  ```python
  start = 0
  end = 5

  name_age = ('Amy', 32)
  name, age = name_age

  a = 1
  b = 2
  a, b = b, a # State: a = 2, b = 1
  ```
- Use descriptive names for the main solution function.
  Helpers can use short names such as `rec` when their role is clear.
- Use the collection conventions introduced in the earlier chapters.
  Prefer names that describe the contents when possible.

  | Value | Naming convention | Example |
  | --- | --- | --- |
  | List or set | A plural name for its contents | `nums`, `names` |
  | String | `txt` or a name that describes the text | `txt`, `message` |
  | Dictionary | `key_to_val` | `name_to_age` |
  | Graph adjacency mapping | `gph` | `gph` |
  | Tuple | `field1_field2` | `name_age` |
  | List of tuples | `field1_field2_tups` | `name_age_tups` |
  | Dictionary items view | A name ending in `_itms` | `name_age_itms` |

  Prefixes such as `dd_`, `ro_`, and `uq_` are optional and can distinguish related variables used in the same scope.
- Prefer single quotes for simple strings, and use double quotes when they avoid escaping an apostrophe.
  Both quote styles are valid Python.

  ```python
  txt = 'hello'
  message = "Don't repeat work."
  ```
- Use snake_case for variable and function names that contain multiple words.

  ```python
  max_sum = 0
  ```
- Avoid Python keywords and names that shadow built-in functions or types.
  Keywords cannot be used as variable names.
  Names such as `str`, `list`, and `sum` are legal identifiers, but assigning to them hides the corresponding built-in names.

  ```python
  # Avoid: str = str(123)
  txt = str(123) # Returns: '123'
  ```
- Prefer separate local variables for transformed input values when that makes the code easier to follow.
  Assigning a new integer to a parameter does not change the caller's variable.
  Changing the contents of a list passed to a function changes the caller's list too, so copy it when mutation is not intended.

  ```python
  def increment(num: int) -> int:
      new_num = num + 1
      return new_num


  num = 2
  increment(num) # Returns: 3
  num # Returns: 2
  ```
- Use enums for algorithm choices, as in [Chapter 08](ch08-divide_and_conquer.md) and [Chapter 10](ch10-graph.md).
  Make selector parameters required and handle each supported value explicitly.
  Use a final `else` to raise an exception for unsupported values.
  Plain constants are useful for fixed numeric positions.

  ```python
  from enum import Enum, auto


  class SearchMethod(Enum):
      RECURSIVE = auto()
      ITERATIVE = auto()


  method = SearchMethod.ITERATIVE

  # Constants identify the positions in a start/end tuple.
  START = 0
  END = 1
  start_end = (3, 8)
  start_end[START] # Returns: 3
  start_end[END] # Returns: 8
  ```
- When a nested function parameter repeats an outer parameter's name, prefix it with `_` to distinguish the two.
  The `_n` parameter in [Chapter 12](ch12-dynamic_programming.md) follows this convention.
- Tuples work well for small groups of values.
  Use `@dataclass` when named fields improve readability.
  `frozen=True` prevents ordinary field assignment, while `order=True` compares instances by their fields in declaration order.
  Mutable objects stored inside a frozen dataclass can still change.

  ```python
  from dataclasses import dataclass


  @dataclass(frozen=True, order=True)
  class Contact:
      name: str
      age: int


  contact = Contact('Amy', 32)
  contact.name # Returns: 'Amy'
  Contact('Amy', 32) == contact # Returns: True
  contact < Contact('Bob', 25) # Returns: True => Name is compared before age.
  ```
- Use `nonlocal` when a nested function assigns a new value to a variable in an enclosing function.
  Calling `append()` on an outer list does not need `nonlocal` unless the list variable itself is reassigned.
  The example below counts nodes whose value is at least as large as every earlier value on their path from the root.

  ```python
  from __future__ import annotations

  import math
  from typing import Optional


  class TreeNode:
      def __init__(self, val: int, lft: Optional[TreeNode], rgt: Optional[TreeNode]) -> None:
          self.val = val
          self.lft = lft
          self.rgt = rgt


  def count_good_nodes(rt: Optional[TreeNode]) -> int:
      res = 0

      def rec(nd: Optional[TreeNode], max_val: float) -> None:
          nonlocal res
          # Deep trees can exceed Python's recursion-depth limit.
          if nd is None:
              return
          if nd.val >= max_val:
              res += 1

          next_max = max(max_val, nd.val)
          rec(nd.lft, next_max)
          rec(nd.rgt, next_max)

      rec(rt, -math.inf)
      return res


  rt = TreeNode(3, TreeNode(1, None, None), TreeNode(4, None, None))
  count_good_nodes(rt) # Returns: 2
  count_good_nodes(None) # Returns: 0
  ```
