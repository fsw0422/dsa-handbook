# Dynamic Programming

Simply put, Dynamic Programming is an optimization technique for _Optimal Substructure_ problems where there exist _Overlapping Sub-problems_.
Any problem that satisfies this condition can be a candidate for optimization with Dynamic Programming.
However for instance, Divide and Conquer solutions discussed in previous chapter (merge sort, binary search etc) by definition has no Overlapping Sub-problems, thus is not a candidate for optimization.

Let's revisit Fibonacci Sequence calculation on how Dynamic Programming can optimize this problem.

```python
...

def fib(num: int) -> int:
  """
  TC: O(2^N)
  SC: O(N)
  """

  if num <= 1:
    return num

  return fib(num - 1) + fib(num - 2)
```

- _Memoization_:
  Top-down approach of Dynamic Programming.

    ```python
    ...

    def fib_memoized(num: int) -> int:
        """
        Memoization usually use Divide and Conquer technique, which makes recursion a popular choice

        TC: O(N)
        SC: O(N)
        """

        # DO NOT initialize cache with 'None', as it often causes confusion when compared in conditional statements with 'False' and 0
        memo = [0 for _ in range(num + 1)]

        def dfs(n: int) -> int:
            if n <= 1:
                return n

            if memo[n] > 0:
                return memo[n]
  
            memo[n] = dfs(n - 1) + dfs(n - 2)
            return memo[n]

        return dfs(num)
    ```

- _Tabulation_:
  Bottom-up approach of Dynamic Programming.

    ```python
    ...
  
    def fib_tabulation(num: int) -> int:
        """
        Tabulation is an iterative approach by ordering the computation bottom-up

        TC: O(N)
        SC: O(N)
        """

        # Safer if we cover base cases (0, 1) as edge cases
        if num <= 1:
            return num
  
        # DO NOT initialize cache with 'None', as it often causes confusion when compared in conditional statements with 'False' and 0
        dp = [0 for _ in range(num + 1)]
  
        dp[0], dp[1] = 0, 1
        for i in range(2, num + 1):
            dp[i] = dp[i - 1] + dp[i - 2]
        return dp[num]


    def fib_tabulation_space_optimized(num: int) -> int:
        """
        You'll notice that after using `f[n - 1]` and `f[n - 2]`, the values are not used afterward therefore, we can further optimize space as below.

        TC: O(N)
        SC: O(1)
        """

        # Safer if we cover base cases (0, 1) as edge cases
        if num <= 1:
            return num

        prv, cur = 0, 1
        for _ in range(2, num + 1):
            prv, cur = cur, cur + prv # This line is not sequential. Left-side 'prv' and right-side 'prv' is same value
        return cur
    ```

Memoization often comes first as solution as there is a high chance you've solved the problem (without caching the overlapping problems) with recursion due to it's intuitiveness.
However, as Tabulation often is more efficient in terms of space complexity, try solving the problem first with Memoization, and then optimize towards Tabulation if you have time left.
If you have defined the base case well, both Memoization and Tabulation will share the same base case.

- Recurrence Relation problems

    [LeetCode 70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
    
    [LeetCode 198. House Robber](https://leetcode.com/problems/house-robber)
    
    [LeetCode 213. House Robber II](https://leetcode.com/problems/house-robber-ii)

- Backtracking problems

    [LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game)

- Substring problems (mostly use Tabulation)

    [LeetCode 53. Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
    
    [LeetCode 121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)
    
    [LeetCode 1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence)
    
    [LeetCode 238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)
