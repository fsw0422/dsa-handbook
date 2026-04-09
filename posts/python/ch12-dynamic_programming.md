# Dynamic Programming

Simply put, Dynamic Programming is an optimization technique for Optimal Substructure problems where there exist Overlapping Subproblems.
Divide and Conquer solutions discussed in the previous chapter (merge sort, binary search etc) by property have no Overlapping Subproblems, thus is not a candidate for optimization.

Let's revisit the 'nth Fibonacci number' calculation to see how Dynamic Programming can optimize this problem.

- Memoization

  ```python
  ...
  
  def fibonacci_memoized(n: int) -> int:
      """
      Starts from the original problem and descends toward the base-case (hence top-down approach)
  
      TC: O(N)
      SC: O(N)
  
      Constraint: 0 <= n <= 45
      """
  
      memo = [-1 for _ in range(n + 1)]
  
      def rec(_n: int) -> int
          if _n <= 1:
              return _n
  
          if memo[_n] != -1:
              return memo[_n]
  
          memo[_n] = rec(_n - 1) + rec(_n - 2)
          return memo[_n]
  
      return rec(n)
  ```
- Tabulation

  ```python
  ...
  
  def fibonacci_tabulation(n: int) -> int:
      """
      Starts from the base-case and ascends toward the original problem (hence bottom-up approach)
  
      TC: O(N)
      SC: O(N)
  
      Constraint: 0 <= n <= 45
      """
  
      if n <= 1:
          return n
  
      dp = [-1 for _ in range(n + 1)]
  
      dp[0], dp[1] = 0, 1
      for i in range(2, n + 1):
          dp[i] = dp[i - 1] + dp[i - 2]
      return dp[n]
  
  
  def fibonacci_tabulation_space_optimized(n: int) -> int:
      """
      TC: O(N)
      SC: O(1)
  
      Constraint: 0 <= num <= 45
      """
  
      if n <= 1:
          return n
  
      prv = 0
      cur = 1
      for _ in range(2, n + 1):
          prv, cur = cur, cur + prv # This line is not sequential. Left-side 'prv' and right-side 'prv' is same value
      return cur
  ```

Any problem (most likely will be Bruteforcing or Backtracking problems in interviews) that satisfies this condition can be a candidate for optimization with Dynamic Programming.
- Recurrence Relation problems:
  Recurrence Relation problems are classic problems that can be optimally solved with Dynamic Programming.
  - [LeetCode 70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
  - [LeetCode 198. Min Cost Climbing Stairs](https://leetcode.com/problems/min-cost-climbing-stairs)
  - [LeetCode 198. House Robber](https://leetcode.com/problems/house-robber)
  - [LeetCode 213. House Robber II](https://leetcode.com/problems/house-robber-ii)
  - [LeetCode 1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence)
- Backtracking problems:
  Backtracking problems can be solved optimally with Dynamic Programming however, if constraints get complicated, it's not easy to identify overlapping subproblems.
  In most cases, Backtracking solution will be enough to pass the interview however, there are some Backtracking problems where overlapping subproblems are easier to identify, thus can be further optimized with Dynamic Programming.
  - [LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game)
  - [LeetCode 45. Jump Game II](https://leetcode.com/problems/jump-game-ii)
  - [LeetCode 322. Coin Change](https://leetcode.com/problems/coin-change)
  - [LeetCode 518. Coin Change II](https://leetcode.com/problems/coin-change-ii)
- Sub-list / Sub-string problems:
  Tabulation is mostly used to solve these problems.
  - [LeetCode 53. Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
  - [LeetCode 121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)
  - [LeetCode 238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)

## Tips

- Memoization should come up first as optimization because it's more intuitive than tabulation (non-memoized version is basically the plain DFS function).
However, as Tabulation often is more efficient in terms of space complexity (since it does not use the recursion call stack), try solving the problem first with Memoization, and then optimize towards Tabulation if interviewer explicitly asks for a bottom-up approach.
Tabulation, as explained above can also (but not always) lead to further space optimization as well.
If you have defined the base case well, both Memoization and Tabulation will share the same base case and similar code structure.
- If the problem asks for anything in context of min / max / number-of-XYZ etc that requires exploration OR anything in context of prefix sum, it is highly likely to be solved optimally with Dynamic Programming.
As described in the first bullet-point, when initially coming up with a DFS function to solve these problems, the function will often return a type of either `int` or `bool`.
These return values are likely cacheable, thus eligible for Memoization.
