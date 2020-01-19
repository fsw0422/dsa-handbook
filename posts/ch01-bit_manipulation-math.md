# Bit Manipulation

Before diving in, please review _Two's Complement_ which is used for representing signed integers.
Python has many built-in types, and they are all objects (there are no such thing as primitive types like Java or C++).
However, primary ones that are most used are

- `bool`:
  Either `True` or `False`.

- `int`:
  Has infinite precision, meaning it can hold very large number that is bound to system memory (`2^63-1` for 64-bit system).

- `float`:
  Does not have infinite precision (follows _IEEE 754 Floating-Point-Standard_).

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
num <<= n # Left shift 'n' bits from 'num' (Multiply 'num' by 2^'n')
num >>= n # Right shift 'n' bits from 'num' (Divide 'num' by 2^'n'. Fills left-side bits with MSB as Python only has signed integer concept)

"""
Tricks that help if you know them by heart
"""
num = ~num + 1 # Two's complement of 'num'
num = (num >> (n - 1)) & 1 # Get 'n'th bit
num = num | (1 << n) # Sets the 'n'th bit to 1
num = num & ~(1 << n) # Sets the 'n'th bit to 0
```

[LetCode 191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits)

# Math

```python
import math
import random


"""
Basic Operations
"""
abs(-1) # 1
max(5, 3) # 5
min(5, 3) # 3
str(23) # '23' (str)
int('23') # 23 (int)
float('3.14') # 3.14 (float)

"""
Additional math functions
"""
math.ceil(3.12) # 4 (int)
math.floor(3.12) # 3 (int)
math.sqrt(9) # 3
math.inf # float('Inf')
-math.inf # float(-'Inf')

"""
Random functions
"""
random.randrange(5) # Random number of range [0, 5)
random.randint(0, 3) # Random number of range [start, end]
random.random() # Random number between [0.0, 1.0)
random.shuffle([1, 3, 2, 4]) # In-place shuffles the list
random.choice([1, 3, 2, 4]) # Random single item from list
```

[LeetCode 50. Pow(x, n)](https://leetcode.com/problems/powx-n)

[LeetCode 204. Count Primes](https://leetcode.com/problems/count-primes)
