# Dynamic Programming

Simply put, Dynamic Programming is an optimization technique for Optimal Substructure problems where there exist Overlapping Subproblems.
Any problem (most likely will be Recurrence Relation or Backtracking problems in interviews) that satisfies this condition can be a candidate for optimization with Dynamic Programming.
Divide and Conquer solutions discussed in the previous chapter (merge sort, binary search etc) by definition have no Overlapping Subproblems, thus is not a candidate for optimization.

Let's revisit Fibonacci sequence calculation to see how Dynamic Programming can optimize this problem.

- DFS without cache

    ```typescript
    ...

    function fib(num: number): number {
        /**
         * TC: O(2^N)
         * SC: O(N)
         *
         * Constraint: 0 <= num <= 45
         */

        if (num <= 1) return num;

        return fib(num - 1) + fib(num - 2);
    }
    ```
- Memoization (DFS with cache)

    ```typescript
    ...

    function fibMemoized(num: number): number {
        /**
         * Starts from the original problem and descends toward the base-case (hence top-down approach)
         *
         * TC: O(N)
         * SC: O(N)
         *
         * Constraint: 0 <= num <= 45
         */

        const memo: number[] = new Array(num + 1).fill(-1);

        function dfs(n: number): number {
            if (n === 0) return 0;
            if (n === 1) return 1;

            if (memo[n] !== -1) return memo[n];

            memo[n] = dfs(n - 1) + dfs(n - 2);
            return memo[n];
        }

        return dfs(num);
    }
    ```
- Tabulation

    ```typescript
    ...

    function fibTabulation(num: number): number {
        /**
         * Starts from the base-case and ascends toward the original problem (hence bottom-up approach)
         *
         * TC: O(N)
         * SC: O(N)
         *
         * Constraint: 0 <= num <= 45
         */

        if (num <= 1) return num;

        const dp: number[] = new Array(num + 1).fill(-1);

        dp[0] = 0;
        dp[1] = 1;
        for (let i = 2; i <= num; i++) {
            dp[i] = dp[i - 1] + dp[i - 2];
        }
        return dp[num];
    }

    function fibTabulationSpaceOptimized(num: number): number {
        /**
         * TC: O(N)
         * SC: O(1)
         *
         * Constraint: 0 <= num <= 45
         */

        if (num <= 1) return num;

        let prv = 0;
        let cur = 1;
        for (let i = 2; i <= num; i++) {
            [prv, cur] = [cur, cur + prv]; // This line is not sequential. Left-side 'prv' and right-side 'prv' is same value
        }
        return cur;
    }
    ```
- Recurrence Relation problems:
  Recurrence Relation problems are classic problems that can be optimally solved with Dynamic Programming.
  - [LeetCode 70. Climbing Stairs](https://leetcode.com/problems/climbing-stairs)
  - [LeetCode 198. Min Cost Climbing Stairs](https://leetcode.com/problems/min-cost-climbing-stairs)
  - [LeetCode 198. House Robber](https://leetcode.com/problems/house-robber)
  - [LeetCode 213. House Robber II](https://leetcode.com/problems/house-robber-ii)
  - [LeetCode 1143. Longest Common Subsequence](https://leetcode.com/problems/longest-common-subsequence)
- Sub-array / Sub-string problems:
  Tabulation is mostly used to solve these problems.
  - [LeetCode 53. Maximum Subarray](https://leetcode.com/problems/maximum-subarray)
  - [LeetCode 121. Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock)
  - [LeetCode 238. Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self)
- Backtracking problems:
Backtracking problems can be solved optimally with Dynamic Programming however, if constraints get complicated, it's not easy to identify overlapping subproblems.
In most cases, Backtracking solution will be enough to pass the interview however, there are some Backtracking problems where overlapping subproblems are easier to identify, thus can be further optimized with Dynamic Programming.
  - [LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game)
  - [LeetCode 45. Jump Game II](https://leetcode.com/problems/jump-game-ii)

## Tips

- Memoization should come up first as solution because it's more intuitive (non-memoized version is basically the plain DFS function).
However, as Tabulation often is more efficient in terms of space complexity (since it does not use the recursion call stack), try solving the problem first with Memoization, and then optimize towards Tabulation if interviewer explicitly asks for a bottom-up approach.
Tabulation, as explained above can also (but not always) lead to further space optimization as well.
If you have defined the base case well, both Memoization and Tabulation will share the same base case and similar code structure.
- If the problem asks for anything in context of min / max / number-of-XYZ etc that requires exploration OR anything in context of prefix sum, it is highly likely to be solved optimally with Dynamic Programming.
As described in the first bullet-point, when initially coming up with a DFS function to solve these problems, the function will often return a type of either `number` or `boolean`.
These return values are likely cacheable, thus eligible for Memoization.
