# Dynamic Programming

Dynamic programming builds answers from smaller subproblem answers and reuses their results.
Depending on the problem, these answers may represent a best result (using optimal substructure), a count, or whether a solution exists.

Divide-and-conquer algorithms such as merge sort and binary search from Chapter 08 usually solve distinct subproblems, so memoization offers little benefit.

Let's revisit the nth Fibonacci number to see how dynamic programming avoids repeated work.
Each function below accepts a nonnegative integer `n`.

For an input index `N = n`, the complexity labels count additions and stored integers.
Python's arbitrary-precision integers grow in size, so their arithmetic and memory costs grow too.

- Memoization

  ```python
  ...
  
  def fibonacci_memoized(n: int) -> int:
      """
      Start from n and recurse toward the base cases, caching computed results.
  
      TC: O(N) additions.
      SC: O(N) cached integers and recursive call frames.
      """

      if n < 0:
          raise ValueError("n must be nonnegative")
  
      memo = [-1 for _ in range(n + 1)]
  
      def rec(_n: int) -> int:
          # Deep recursion can exceed Python's recursion-depth limit.
          if _n <= 1:
              return _n
  
          if memo[_n] != -1:
              return memo[_n]
  
          memo[_n] = rec(_n - 1) + rec(_n - 2)
          return memo[_n]
  
      return rec(n)


  fibonacci_memoized(10) # Returns: 55
  ```
- Tabulation

  ```python
  ...
  
  def fibonacci_tabulation(n: int) -> int:
      """
      Build results from the base cases up to n.
  
      TC: O(N) additions.
      SC: O(N) stored integers.
      """

      if n < 0:
          raise ValueError("n must be nonnegative")
  
      if n <= 1:
          return n
  
      dp = [-1 for _ in range(n + 1)]
  
      dp[0], dp[1] = 0, 1
      for i in range(2, n + 1):
          dp[i] = dp[i - 1] + dp[i - 2]
      return dp[n]
  
  
  def fibonacci_tabulation_space_optimized(n: int) -> int:
      """
      Keep only the two values needed to compute the next value.
  
      TC: O(N) additions.
      SC: O(1) stored integers.
      """

      if n < 0:
          raise ValueError("n must be nonnegative")
  
      if n <= 1:
          return n
  
      prv = 0
      cur = 1
      for _ in range(2, n + 1):
          prv, cur = cur, cur + prv # Both right-side expressions are evaluated before either variable is updated.
      return cur


  fibonacci_tabulation(10) # Returns: 55
  fibonacci_tabulation_space_optimized(10) # Returns: 55
  ```

Look for repeated states whose results can be reused.

- Recurrence relations:
  A recurrence can benefit from DP when its subproblems overlap.

  - [LeetCode 70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
  - [LeetCode 746. Min Cost Climbing Stairs](https://leetcode.com/problems/min-cost-climbing-stairs)
  - [LeetCode 198. House Robber](https://leetcode.com/problems/house-robber)
  - [LeetCode 213. House Robber II](https://leetcode.com/problems/house-robber-ii)
  - [LeetCode 1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence)
- Backtracking problems:
  Memoization can speed up backtracking when different paths reach the same state.
  Include every detail that affects future choices in that state.

  - [LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game)
  - [LeetCode 45. Jump Game II](https://leetcode.com/problems/jump-game-ii)
  - [LeetCode 322. Coin Change](https://leetcode.com/problems/coin-change)
  - [LeetCode 518. Coin Change II](https://leetcode.com/problems/coin-change-ii)
- Array and string problems:
  DP can track the best result ending at a position or over a prefix.

  - [LeetCode 53. Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
  - [LeetCode 121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)

Prefix and suffix products are a related array technique.

- [LeetCode 238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)

## Tips

Consider DP when:

- An answer can be built from answers to smaller subproblems.
- The same states recur, and their stored results can be reused.
- For minimum, maximum, shortest, or longest questions, check whether the problem has optimal substructure (see [Chapter 07](ch07-recursion_and_subproblems.md#optimal-substructure)).
- For counting or reachability questions, counts or boolean answers from smaller subproblems can be combined.

After identifying that the problem can be solved with DP:

- Start with a correct recursive solution and clear base cases, then add memoization to avoid repeated work.
  Memoization is often more intuitive because it keeps the recursive structure.
  Once it works, consider converting it to tabulation to avoid recursive calls and possibly reduce storage.
  Tabulation computes states in an order where their dependencies are already available.
- Include every changing input that affects the subproblem's answer in the state.
  Use those values as the cache key, so calls with the same state can reuse the same answer.
  For Coin Change with fixed denominations, the remaining amount is enough to identify the subproblem.
