# Bit Manipulation

Before diving in, please review Two's Complement which is used to represent signed integers.
TypeScript inherits JavaScript's type system where `number` is a 64-bit IEEE 754 floating-point (double precision).
However, bitwise operators convert operands to 32-bit signed integers.

- `boolean`:
  Either `true` or `false`.
- `number`:
  64-bit floating-point. Bitwise operations work on 32-bit signed integers internally.
- `bigint`:
  Arbitrary precision integer (similar to Python's `int`).

```typescript
...

/**
 * Basic Operations
 */
let num: number = ...;
let n: number = ...;
num &= n; // AND
num |= n; // OR
num ^= n; // XOR
num = ~num; // 'num''s complement
num <<= n; // Left shift 'n' bits from 'num' => Multiply 'num' by 2^'n'
num >>= n; // Arithmetic right shift 'n' bits from 'num' => Divide 'num' by 2^'n'. Fills left-side bits with MSB
num >>>= n; // Logical right shift 'n' bits from 'num' => Fills left-side bits with 0

/**
 * Tricks that help if you know them by heart
 */
num = ~num + 1; // Two's complement of 'num'
num = (num >> (n - 1)) & 1; // Get 'n'th bit
num = num | (1 << n); // Sets the 'n'th bit to 1
num = num & ~(1 << n); // Sets the 'n'th bit to 0
```
- [LeetCode 191. Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits)

# Math

```typescript
...

/**
 * Basic Operations
 */
1 + 2; // Returns: 3
5 - 2; // Returns: 3
3 * 4; // Returns: 12
2 ** 3; // Returns: 8
7 / 2; // Returns: 3.5
7 % 2; // Returns: 1 => remainder

[1, 2, 3].reduce((acc, x) => acc + x, 0) // Returns: 6 => Custom sum function
Math.abs(-1); // Returns: 1
Math.max(5, 3); // Returns: 5
Math.min(5, 3); // Returns: 3

/**
 * Additional math functions
 */
Math.ceil(3.12); // Returns: 4
Math.floor(3.12); // Returns: 3
Math.sqrt(9); // Returns: 3
Infinity; // Equivalent to Python's math.inf
-Infinity; // Equivalent to Python's -math.inf

/**
 * Random functions
 */
Math.floor(Math.random() * 5); // Returns: Random number of range [0, 5)
Math.floor(Math.random() * (3 - 0 + 1)) + 0; // Returns: Random number of range [0, 3]
Math.random(); // Returns: Random number between [0.0, 1.0)

// Fisher-Yates shuffle (in-place)
function shuffle(nums: number[]): void {
    for (let i = nums.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [nums[i], nums[j]] = [nums[j], nums[i]];
    }
}

// Random single item from array
const nums = [1, 3, 2, 4];
nums[Math.floor(Math.random() * nums.length)];
```

- [LeetCode 50. Pow(x, n)](https://leetcode.com/problems/powx-n)
- [LeetCode 204. Count Primes](https://leetcode.com/problems/count-primes)
