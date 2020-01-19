# Deque / Stack / Queue

`collections.deque` in Python is implemented as doubly-linked list (although it's never used in Linked List problems).

We will be using Deque as core data structure for both Stack / Queue because it contains all operations needed.

```python
...

from collections import deque


"""
Deque
"""
deq = deque([1, 2, 3])
deq.append(4) # TC: O(1) - [1, 2, 3, 4]
deq.appendleft(0) # TC: O(1) - [0, 1, 2, 3, 4]
deq.pop() # TC: O(1) - 4, [0, 1, 2, 3]
deq.popleft() # TC: O(1) - 0, [1, 2, 2]

"""
Queue
"""
que = deque([1, 2, 3]) # Allocate deque as queue
que.append(4) # TC: O(1) - [1, 2, 3, 4] (Offer)
que.popleft() # TC: O(1) - 1, [2, 3, 4] (Poll)
peek_first = que[0] # TC: O(1) - 2

"""
Stack
"""
stk = deque([1, 2, 3]) # Allocate deque as stack
stk.append(4) # TC: O(1) - [1, 2, 3, 4] (Push)
stk.pop() # TC: O(1) - 4, [1, 2, 3] (Pop)
peek_top = stk[-1] # TC: O(1) - 3

"""
Basic Operations
"""
stk_or_que = deque()
if stk_or_que: # TC: O(1) - If stack or queue is not 'None' and `len(stack_or_queue) > 0` (Mostly used in stacks or queues or deque as items are added / removed frequently)
    ...
while stk_or_que: # TC: O(N) - While stack or queue is not 'None' and `len(stack_or_queue) > 0` (Mostly used in stacks or queues or deque as items are added / removed frequently)
    ...
```

- Deque can contain the snapshot of sliding window.

    [LeetCode 3. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-character)

- Queue is used in BFS later in Graphs.

- Stack can be used for parsing structures.

    [LeetCode 20. Valid Parentheses](https://leetcode.com/problems/valid-parentheses)

One of the most difficult problems are Monotonic Deque / Queue / Stack problems, as intuition often is hard to come up with.

- _Monotonic Deque / Queue_ (Sliding Window / Timestamp problems)

    [LeetCode 239. Sliding Window Maximum](https://leetcode.com/problems/sliding-window-maximum)

    [LeetCode 362. Design Hit Counter](https://leetcode.com/problems/design-hit-counter)

- _Monotonic Stack_

    [LeetCode 155. Min Stack](https://leetcode.com/problems/min-stack)

    [LeetCode 496. Next Greater Element I](https://leetcode.com/problems/next-greater-element-i)

    [LeetCode 503. Next Greater Element II](https://leetcode.com/problems/next-greater-element-ii)
