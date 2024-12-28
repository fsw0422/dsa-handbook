# Greedy

Greedy is an algorithm pattern that chooses local optimal choice on each stage and never change its decision in the following stages.
You can use Greedy to find an optimal solution if the problem has _Optimal Substructure_ (discussed in Divide and Conquer) and _Greedy Choice Property_ (an overall optimal solution can be reached by choosing the optimal choice at each step).

To name a few difference from Dynamic Programming

- Dynamic Programming and Greedy can be both used for optimizing solution for problems having _Optimal Substructure_.

- Dynamic Programming optimize the solution by removing _Overlapping Problems_, however Greedy optimize the solution by applying the Greedy Choice Property.

- Dynamic Programming usually can solve problems that can be solved by Greedy, however is preferable to solve with Greedy if Greedy Choice Property can be met, as it's almost always more optimal than Dynamic Programming.

Therefore on optimization, always try Greedy first and if it doesn't seem to work out, quickly switch to Dynamic Programming.
Unfortunately there is no straight-forward way to tell if a problem meets the Greedy Choice Property (you just need to try it).

Greedy often use the Heap, as it offers efficient min / max element on each stage.

[LeetCode 1167. Minimum Cost to Connect Sticks](https://leetcode.com/problems/minimum-cost-to-connect-sticks)

You may occasionally see a Greedy solution that optimizes Dynamic Programming solution even further.

[LeetCode 55. Jump Game](https://leetcode.com/problems/jump-game)

[LeetCode 45. Jump Game II](https://leetcode.com/problems/jump-game-ii)


## Tips

- If the problem looks like it can be solved with Dynamic Programming, quickly try a Greedy solution if it works.
  If it doesn't, fallback to Dynamic Programming.
