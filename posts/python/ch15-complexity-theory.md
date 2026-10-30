# Complexity Theory

Dynamic programming and greedy can speed up some problems, but neither guarantees polynomial running time.
Complexity theory studies how the resources needed to solve problems grow with the size of the input.

## Complexity Classes

A decision problem asks for a yes-or-no answer.
Polynomial time means the running time is bounded by a polynomial in the input length, such as O(N^2) for an input of length N.
For numeric inputs, include the bits needed to represent the numbers when measuring input length.

| Class | Meaning |
| --- | --- |
| P | Decision problems that can be solved in polynomial time. |
| NP | Decision problems whose yes answers have proposed solutions of polynomial length that can be checked in polynomial time. |
| NP-complete | Problems in NP to which every problem in NP can be converted in polynomial time. |
| NP-hard | Problems to which every problem in NP can be converted in polynomial time, whether or not they belong to NP. |

Here, a conversion must let a solution to the target problem solve the original problem too.
Every problem in P also belongs to NP.
Whether P = NP is [still unresolved](https://www.claymath.org/millennium/p-vs-np/).
A polynomial-time exact algorithm for an NP-hard problem would imply P = NP.
NP-hardness alone therefore does not prove that polynomial-time solutions are impossible.

For an overview, see [P, NP, NP-complete, and NP-hard](https://www.youtube.com/watch?v=YX40hbAHx3s).

## Examples

### 0/1 Knapsack

Select each item at most once while keeping the total weight within a capacity.
Finding the greatest total value is NP-hard.
The decision version asks whether a selection can reach at least a target value without exceeding the capacity and is NP-complete.

With n items, positive integer weights, and a positive integer capacity W, the standard DP has O(n * W) states.
This gives a pseudopolynomial algorithm: its running time depends on the numeric capacity, which can be much larger than the number of bits needed to write it.
Both [top-down](https://www.youtube.com/watch?v=149WSzQ4E1g) and [bottom-up](https://www.youtube.com/watch?v=8LusJS5-AGo&t=290s) DP can solve this formulation.

Partition Equal Subset Sum is a related decision problem: choose a subset whose sum is half the total, using each number at most once.

- [LeetCode 416. Partition Equal Subset Sum](https://leetcode.com/problems/partition-equal-subset-sum)

### Traveling Salesperson

The [Traveling Salesperson Problem](https://www.youtube.com/watch?v=-JjA4BLQyqE) asks for a minimum-cost tour that visits every city once and returns to the start.
Finding that tour is NP-hard, while deciding whether a tour exists within a given cost bound is NP-complete.

Shortest Superstring is a related ordering problem that can use DP over subsets of words.
LeetCode 943 limits the input to 12 words, so an exponential number of subsets can still be manageable.

- [LeetCode 943. Find the Shortest Superstring](https://leetcode.com/problems/find-the-shortest-superstring)

## Tips

- Check the input limits before rejecting an exact solution because the general problem is NP-hard.
- Count the distinct DP states and the work per state.
  Memoization avoids repeated work, but the number of states can still be exponential.
