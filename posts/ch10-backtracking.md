# Backtracking

Backtracking is a technique for solving problems where you explore all possible options and backtrack as soon as you determine the current path cannot lead to a valid solution (pruning).
For this reason, DFS becomes handy for these problem solution, thus often resulting in exponential time complexity.

## Difference between Recurrence Relation
Backtracking and Recurrence Relation (e.g Fibonacci, House Robber without Dynamic Programming) problems are often confused to be in same category, as both often involve recursion.
However, problems that require Backtracking creates a decision tree for a large solution space (e.g get all subsets [large solution space] from a list of numbers by either selecting or not selecting each element in list [decision tree]).
This trait often leads Backtracking solutions to undo decisions in order to explore alternate paths.

[LeetCode 78. Subsets](https://leetcode.com/problems/subsets)

[LeetCode 90. Subsets II](https://leetcode.com/problems/subsets-ii)

[LeetCode 46. Permutations](https://leetcode.com/problems/permutations)

[LeetCode 47. Permutations II](https://leetcode.com/problems/permutations-ii)

[LeetCode 77. Combinations](https://leetcode.com/problems/combinations)

[LeetCode 39. Combination Sum](https://leetcode.com/problems/combination-sum)

[LeetCode 40. Combination Sum II](https://leetcode.com/problems/combination-sum-ii)

[LeetCode 79. Word Search](https://leetcode.com/problems/word-search)

## Tips

- When the problem asks for a result where all exploration paths matter (computing all combination, route of a graph etc), it is highly likely be solved with Backtracking.

- Make sure you draw the call graph for better understanding for yourself as well as the interviewer.
