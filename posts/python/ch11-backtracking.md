# Backtracking

Backtracking explores a sequence of choices, then returns to an earlier state to try another path.
If a choice changes shared state, undo those changes when you return.
A base case ends a search path, while pruning skips a branch that cannot lead to a valid solution.
Depending on the problem, the search may stop after finding one solution or continue to find all solutions.

In many graph and binary tree problems, the structure is given upfront, and the task centers on traversing it.
In backtracking, you explore an implicit decision tree whose nodes are partial solutions and whose branches represent choices.
You generate these states as you explore, without building the entire tree in memory.

Backtracking is commonly used to generate subsets, combinations, and permutations, and to search for words.

- [LeetCode 78. Subsets](https://leetcode.com/problems/subsets)
- [LeetCode 90. Subsets II](https://leetcode.com/problems/subsets-ii)
- [LeetCode 46. Permutations](https://leetcode.com/problems/permutations)
- [LeetCode 47. Permutations II](https://leetcode.com/problems/permutations-ii)
- [LeetCode 77. Combinations](https://leetcode.com/problems/combinations)
- [LeetCode 39. Combination Sum](https://leetcode.com/problems/combination-sum)
- [LeetCode 40. Combination Sum II](https://leetcode.com/problems/combination-sum-ii)
- [LeetCode 79. Word Search](https://leetcode.com/problems/word-search)
