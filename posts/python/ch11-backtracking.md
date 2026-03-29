# Backtracking

Backtracking is a technique for solving problems where you explore all possible options, but revert to previous state (backtrack) as soon as you reach either the base case, or determine the current path cannot lead to a valid solution (pruning).

As the approach is to explore all possible options, it resembles the traversal of a large acylic Graph (Tree) as we've seen in previous chapter.
One difference is that for backtracking problems, you'll often need to construct the decision tree yourself (exploring) opposed to Binary Tree or Graphs, where you're given the data structure (or metadata to construct one) from the beginning.

Computing subsets, combinations, permutations, searching words etc are great candidates of Backtracking.
- [LeetCode 78. Subsets](https://leetcode.com/problems/subsets)
- [LeetCode 90. Subsets II](https://leetcode.com/problems/subsets-ii)
- [LeetCode 46. Permutations](https://leetcode.com/problems/permutations)
- [LeetCode 47. Permutations II](https://leetcode.com/problems/permutations-ii)
- [LeetCode 77. Combinations](https://leetcode.com/problems/combinations)
- [LeetCode 39. Combination Sum](https://leetcode.com/problems/combination-sum)
- [LeetCode 40. Combination Sum II](https://leetcode.com/problems/combination-sum-ii)
- [LeetCode 79. Word Search](https://leetcode.com/problems/word-search)
