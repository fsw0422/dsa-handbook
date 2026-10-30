# Greedy

Greedy is an algorithm pattern that makes a choice at each step without reconsidering earlier choices.
For problems that ask for a best answer, [optimal substructure](ch07-recursion_and_subproblems.md#optimal-substructure) alone does not guarantee a greedy solution.
A greedy approach also needs the greedy-choice property: the next choice can be made safely without comparing every future possibility.
That choice must still allow a best overall solution.

Some problems can be solved using either dynamic programming or greedy.
Dynamic programming reuses subproblem results, while greedy relies on making safe choices at each step.
A greedy approach can be simpler or faster, but compare the actual time and space costs.

Greedy algorithms sometimes use a heap to retrieve the smallest or largest available value efficiently.

- [LeetCode 1167. Minimum Cost to Connect Sticks](https://leetcode.com/problems/minimum-cost-to-connect-sticks)

Greedy can also solve reachability problems.
The following problems have both dynamic programming and greedy solutions.

- [LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game): check whether the last index is reachable.
- [LeetCode 45. Jump Game II](https://leetcode.com/problems/jump-game-ii): find the fewest jumps needed to reach the last index.

## Tips

Before using a greedy rule, explain why each choice is safe for the problem's goal.
Try counterexamples to challenge the rule, but passing a few examples does not prove it correct.
If the rule fails, consider a different rule or another technique, such as dynamic programming.
