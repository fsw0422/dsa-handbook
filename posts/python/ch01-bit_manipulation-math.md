# Bit Manipulation

Before diving in, review two's complement, which is used to represent signed integers.
Python's bitwise operators behave as though integers use two's complement with infinitely many sign bits.
Python has many built-in types, and their values are all objects. Unlike Java or C++, Python has no primitive types.
The most commonly used types are:

- `bool`:
  Either `True` or `False`.
- `int`:
  Has arbitrary precision, so its size is limited only by available memory.
- `float`:
  Has finite precision, typically using IEEE 754 double precision.

```python
...

"""
Basic Operations
"""
num = 5
n = 1
num &= n # AND
num |= n # OR
num ^= n # XOR
num = ~num # Bitwise complement of 'num'
num <<= n # Shift 'num' left by 'n' bits => Multiply 'num' by 2 ** n
num >>= n # Arithmetic right shift by 'n' bits => Floor-divide 'num' by 2 ** n, including for negative values

"""
Useful tricks to learn by heart

Bit indices start at 0 at the least significant bit. Shift counts must be nonnegative.
"""
num = 5
n = 1
neg_num = ~num + 1 # Returns: -5 => Equivalent to -num
bit = (num >> n) & 1 # Returns: 0 => Get the bit at index 'n'
num = num | (1 << n) # State: 7 => Set the bit at index 'n' to 1
num = num & ~(1 << n) # State: 5 => Set the bit at index 'n' to 0
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
7 // 2 # Returns: 3 => Floor division
-7 // 2 # Returns: -4 => Rounds toward negative infinity
7 % 2 # Returns: 1 => Remainder

sum([1,2,3]) # Returns: 6
abs(-1) # Returns: 1
max(5, 3) # Returns: 5
min(5, 3) # Returns: 3

"""
Gotcha
"""
res = 2
res *= 3 + 1 # State: 8 => Same as `res = res * (3 + 1)`

"""
Additional math functions
"""
math.ceil(3.12) # Returns: 4
math.floor(3.12) # Returns: 3
math.sqrt(9) # Returns: 3.0
math.inf # Returns: inf => Same as float('inf')
-math.inf # Returns: -inf => Same as float('-inf')

"""
Random functions
"""
random.randrange(5) # Returns: Random integer in [0, 5)
random.randint(0, 3) # Returns: Random integer in [0, 3], including both endpoints
random.random() # Returns: Random float in [0.0, 1.0)
nums = [1, 3, 2, 4]
random.shuffle(nums) # State: Shuffles 'nums' in place; returns None
random.choice([1, 3, 2, 4]) # Returns: A random item from the list
```

- [LeetCode 50. Pow(x, n)](https://leetcode.com/problems/powx-n)
- [LeetCode 204. Count Primes](https://leetcode.com/problems/count-primes)
