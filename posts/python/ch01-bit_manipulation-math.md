# Bit Manipulation

Before diving in, review two's complement, which is used to represent signed integers.
Python has many built-in types, and their values are all objects. Unlike Java or C++, Python has no primitive types.
The most commonly used types are:

- `bool`:
  Either `True` or `False`.
- `int`:
  Has arbitrary precision, so its size is limited only by available memory.
- `float`:
  Has finite precision and follows the IEEE 754 floating-point standard.

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
num = ~num # Bitwise complement of 'num'
num <<= n # Shift 'num' left by 'n' bits => Multiply 'num' by 2^'n'
num >>= n # Shift 'num' right by 'n' bits => Divide 'num' by 2^'n'. Fill the leftmost bits with the MSB, since Python integers are signed

"""
Useful tricks to learn by heart
"""
num = ~num + 1 # Two's complement of 'num'
num = (num >> (n - 1)) & 1 # Get the nth bit
num = num | (1 << n) # Set the nth bit to 1
num = num & ~(1 << n) # Set the nth bit to 0
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
Gotcha
"""
res = 2
res *= 3 + 1 # Returns: 8 => Same as `res = res * (3 + 1)`

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
random.randrange(5) # Returns: Random integer in [0, 5)
random.randint(0, 3) # Returns: Random integer in [start, end]
random.random() # Returns: Random number in [0.0, 1.0)
random.shuffle([1, 3, 2, 4]) # State: Shuffles the list *in place*
random.choice([1, 3, 2, 4]) # Returns: A random item from the list
```

- [LeetCode 50. Pow(x, n)](https://leetcode.com/problems/powx-n)
- [LeetCode 204. Count Primes](https://leetcode.com/problems/count-primes)
