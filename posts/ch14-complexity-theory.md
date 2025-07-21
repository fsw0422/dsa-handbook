# Complexity Theory

Dynamic Programming and Greedy patterns help us achieve _Polynomial Runtime_ on problems that otherwise require _Exponential Runtime_.
However, there are vast amount of problems that the only-known current solution has an Exponential Runtime.
This is the part where Complexity Theory comes in to classify problems based on their status of time complexity.
Make sure to understand the [concepts of _P / NP_, _NP Complete_ and _NP Hard_](https://www.youtube.com/watch?v=YX40hbAHx3s).
NP Complete or NP Hard problems are out of scope for interviews since proving that the problem is NP Complete or NP Hard is non-trivial.
However, if you know some well-known algorithms, you can at least mention to the interviewer that the problem cannot be solved with Polynomial Runtime.
Here are some well-known problems.

_0/1 Knapsack Problem_ (_NP Complete_):
Can be solved both ways, [Top-down](https://www.youtube.com/watch?v=149WSzQ4E1g) / [Bottom-up](https://www.youtube.com/watch?v=8LusJS5-AGo&t=290s)
- [LeetCode 416. Partition Equal Subset Sum](https://leetcode.com/problems/partition-equal-subset-sum)

[_Travelling Salesmen Problem_](https://www.youtube.com/watch?v=-JjA4BLQyqE) (_NP Complete_ for decision / _NP Hard_ for optimization)
- [LeetCode 943. Find the Shortest Superstring](https://leetcode.com/problems/find-the-shortest-superstring)
