# Deque / Stack / Queue

`collections.deque` in Python is implemented as doubly-linked list (although it's never used in Linked List problems).

We will be using Deque as core data structure for both Stack / Queue because it contains all operations needed.

```python
...

from collections import deque


"""
Deque - Allocation & Basic Operations
"""
deq = deque([1, 2, 3])
deq.append(4) # TC: O(1) - State: [1, 2, 3, 4]
deq.appendleft(0) # TC: O(1) - State: [0, 1, 2, 3, 4]
deq.pop() # TC: O(1) - Returns: 4, State: [0, 1, 2, 3]
deq.popleft() # TC: O(1) - Returns: 0, State: [1, 2, 3]

if deq: # TC: O(1) - If stack or queue is not 'None' and `len(stack_or_queue) > 0` => Mostly used in stacks or queues or deque as items are added / removed frequently
    ...
while deq: # TC: O(N) - While stack or queue is not 'None' and `len(stack_or_queue) > 0` => Mostly used in stacks or queues or deque as items are added / removed frequently
    ...

"""
Queue - Allocation & Basic Operations
"""
que = deque([1, 2, 3]) # Allocate deque as queue
que.append(4) # TC: O(1) - State: [1, 2, 3, 4] => Enqueue
que.popleft() # TC: O(1) - Returns: 1, State: [2, 3, 4] => Dequeue
que[0] # TC: O(1) - Returns: 2 => Front

"""
Stack - Allocation & Basic Operations
"""
stk = deque([1, 2, 3]) # Allocate deque as stack
stk.append(4) # TC: O(1) - State: [1, 2, 3, 4] => Push
stk.pop() # TC: O(1) - Returns: 4, State: [1, 2, 3] => Pop
stk[-1] # TC: O(1) - Returns: 3 => Peek

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
