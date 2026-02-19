# Bit Manipulation

Before diving in, please review Two's Complement which is used to represent signed integers.
Python has many built-in types, and they are all objects (there are no such thing as primitive types like Java or C++).
However, primary ones that are most used are

- `bool`:
  Either `True` or `False`.
- `int`:
  Has infinite precision, meaning it can hold very large number that is bound to system memory (`2^63-1` for 64-bit system).
- `float`:
  Does not have infinite precision (follows IEEE 754 Floating Point Standard).

```python
...

"""
Basic Operations
"""
num = ...
n = ...
num &= n # AND
num |= n # OR
num ^= n # XOR
num = ~num # 'num''s complement
num <<= n # Left shift 'n' bits from 'num' => Multiply 'num' by 2^'n'
num >>= n # Right shift 'n' bits from 'num' => Divide 'num' by 2^'n'. Fills left-side bits with MSB as Python only has signed integer concept

"""
Tricks that help if you know them by heart
"""
num = ~num + 1 # Two's complement of 'num'
num = (num >> (n - 1)) & 1 # Get 'n'th bit
num = num | (1 << n) # Sets the 'n'th bit to 1
num = num & ~(1 << n) # Sets the 'n'th bit to 0
```
- [LeetCode 191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits)

# Math

```python
import math
import random


"""
Basic Operations
"""
1 + 2 # Returns: 3
5 - 2 # Returns: 3
3 * 4 # Returns: 12
2 ** 3 # Returns: 8
7 / 2 # Returns: 3.5
7 // 2 # Returns: 3 => Quotient
7 % 2 # Returns: 1 => Remainder

sum([1,2,3]) # Returns: 6
abs(-1) # Returns: 1
max(5, 3) # Returns: 5
min(5, 3) # Returns: 3

"""
Additional math functions
"""
math.ceil(3.12) # Returns: 4
math.floor(3.12) # Returns: 3
math.sqrt(9) # Returns: 3
math.inf # Returns: float('Inf')
-math.inf # Returns: float(-'Inf')

"""
Random functions
"""
random.randrange(5) # Returns: Random number of range [0, 5)
random.randint(0, 3) # Returns: Random number of range [start, end]
random.random() # Returns: Random number between [0.0, 1.0)
random.shuffle([1, 3, 2, 4]) # State: *In-place* shuffles the list
random.choice([1, 3, 2, 4]) # Returns: Random single item from list
```

- [LeetCode 50. Pow(x, n)](https://leetcode.com/problems/powx-n)
- [LeetCode 204. Count Primes](https://leetcode.com/problems/count-primes)
