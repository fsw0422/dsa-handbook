# Deque / Stack / Queue

We will be using [@datastructures-js](https://datastructures-js.info/) packages which provide performant, type-safe implementations with O(1) operations across the board (unlike raw arrays where `shift`/`unshift` are O(N)).

```typescript
...

import { Deque } from '@datastructures-js/deque';
import { Queue } from '@datastructures-js/queue';
import { Stack } from '@datastructures-js/stack';


/**
 * Deque - Allocation & Basic Operations
 */
const deq = new Deque<number>([1, 2, 3]);
deq.pushBack(4); // TC: O(1) - State: [1, 2, 3, 4]
deq.pushFront(0); // TC: O(1) - State: [0, 1, 2, 3, 4]
deq.popBack(); // TC: O(1) - Returns: 4, State: [0, 1, 2, 3]
deq.popFront(); // TC: O(1) - Returns: 0, State: [1, 2, 3]
deq.front(); // TC: O(1) - Returns: 1
deq.back(); // TC: O(1) - Returns: 3

if (!deq.isEmpty()) { ... } // TC: O(1) - If deque is not empty => Mostly used in stacks or queues or deque as items are added / removed frequently
while (!deq.isEmpty()) { ... } // TC: O(N) - While deque is not empty => Mostly used in stacks or queues or deque as items are added / removed frequently

/**
 * Queue - Allocation & Basic Operations
 */
const que = new Queue<number>([1, 2, 3]);
que.enqueue(4); // TC: O(1) - State: [1, 2, 3, 4]
que.dequeue(); // TC: O(1) Amortized - Returns: 1, State: [2, 3, 4]
que.front(); // TC: O(1) - Returns: 2

/**
 * Stack - Allocation & Basic Operations
 */
const stk = new Stack<number>([1, 2, 3]);
stk.push(4); // TC: O(1) - State: [1, 2, 3, 4]
stk.pop(); // TC: O(1) - Returns: 4, State: [1, 2, 3]
stk.peek(); // TC: O(1) - Returns: 3
```

Deque can contain the snapshot of sliding window.
- [LeetCode 3. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-character)

Queue is used in BFS later in Graphs.

Stack can be used for parsing structures.
- [LeetCode 20. Valid Parentheses](https://leetcode.com/problems/valid-parentheses)

Monotonic Deque / Queue (Sliding Window / Timestamp problems)
- [LeetCode 239. Sliding Window Maximum](https://leetcode.com/problems/sliding-window-maximum)
- [LeetCode 362. Design Hit Counter](https://leetcode.com/problems/design-hit-counter)

Monotonic Stack
- [LeetCode 155. Min Stack](https://leetcode.com/problems/min-stack)
- [LeetCode 496. Next Greater Element I](https://leetcode.com/problems/next-greater-element-i)
- [LeetCode 503. Next Greater Element II](https://leetcode.com/problems/next-greater-element-ii)
