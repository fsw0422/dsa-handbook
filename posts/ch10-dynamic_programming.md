# Dynamic Programming

Simply put, Dynamic Programming is an optimization technique for _Optimal Substructure_ problems where there exist _Overlapping Sub-problems_.
Any problem that satisfies this condition can be a candidate for optimization with Dynamic Programming.
However for instance, Divide and Conquer solutions discussed in previous chapter (merge sort, binary search etc) by definition has no Overlapping Sub-problems, thus is not a candidate for optimization.

Let's revisit Fibonacci Sequence calculation on how Dynamic Programming can optimize this problem.

- _Brute Force_

    ```python
    ...
    
    def fib(num: int) -> int:
        """
        TC: O(2^N)
        SC: O(N)
    
        Constraint: 0 <= num <= 45
        """
    
        if num <= 1:
            return num
    
        return fib(num - 1) + fib(num - 2)
    ```

- _Memoization_

    ```python
    ...

    def fib_memoized(num: int) -> int:
        """
        Starts from the original problem and descends toward the base-case (hence top-down approach)

        TC: O(N)
        SC: O(N)

        Constraint: 0 <= num <= 45
        """

        memo = [-1 for _ in range(num + 1)]

        def dfs(n: int) -> int:
            if n <= 1:
                return n

            if memo[n] != -1:
                return memo[n]
  
            memo[n] = dfs(n - 1) + dfs(n - 2)
            return memo[n]

        return dfs(num)
    ```

- _Tabulation_

    ```python
    ...
  
    def fib_tabulation(num: int) -> int:
        """
        Starts from the base-case and ascends toward the original problem (hence bottom-up approach)

        TC: O(N)
        SC: O(N)

        Constraint: 0 <= num <= 45
        """

        if n <= 1:
            return n

        dp = [-1 for _ in range(num + 1)]
  
        dp[0] = 0
        dp[1] = 1
        for i in range(2, num + 1):
            dp[i] = dp[i - 1] + dp[i - 2]
        return dp[num]


    def fib_tabulation_space_optimized(num: int) -> int:
        """
        TC: O(N)
        SC: O(1)

        Constraint: 0 <= num <= 45
        """

        if n <= 1:
            return n

        prv = 0
        cur = 1
        for _ in range(2, num + 1):
            prv, cur = cur, cur + prv # This line is not sequential. Left-side 'prv' and right-side 'prv' is same value
        return cur
    ```

Memoization often comes first as solution because it's more intuitive since the non-memoized version is basically the brute-force version.
However, as Tabulation often is more efficient in terms of space complexity (since it does not use the recursion call stack), try solving the problem first with Memoization, and then optimize towards Tabulation if you have time left.
Tabulation as explained above can also (but not always) lead to further space optimization as well.
If you have defined the base case well, both Memoization and Tabulation will share the same base case.

- Recurrence Relation problems

    [LeetCode 70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
    
    [LeetCode 198. House Robber](https://leetcode.com/problems/house-robber)
    
    [LeetCode 213. House Robber II](https://leetcode.com/problems/house-robber-ii)

- Substring problems (mostly use Tabulation)

    [LeetCode 53. Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
    
    [LeetCode 121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)
    
    [LeetCode 1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence)
    
    [LeetCode 238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)

- Backtracking problems

    Backtracking problems can be also solved with Dynamic Programming, as often there are overlapping sub-problems. If you are interested, try solving them with Dynamic Programming and see how time / space complexity differs with the original Backtracking solution.