# Deque / Stack / Queue

In CPython, `collections.deque` stores elements in a doubly linked chain of fixed-size blocks.
It supports efficient appends and removals at both ends.

A queue uses FIFO: first in, first out.
A stack uses LIFO: last in, first out.
These examples use a deque for both.
A Python list also works well as a stack with `append()` and `pop()`, but removing its first element takes O(N) time.

Deque indexing takes O(1) time at either end and O(N) time in the middle.
Removing or peeking at an empty deque raises `IndexError`.

```python
...

from collections import deque


"""
Deque - Allocation & Basic Operations

State annotations show the deque's contents.
"""
deq = deque([1, 2, 3])
deq.append(4) # TC: O(1) - State: [1, 2, 3, 4]
deq.appendleft(0) # TC: O(1) - State: [0, 1, 2, 3, 4]
deq.pop() # TC: O(1) - Returns: 4, State: [0, 1, 2, 3]
deq.popleft() # TC: O(1) - Returns: 0, State: [1, 2, 3]

if deq: # TC: O(1) => True when the deque is nonempty
    front = deq[0] # Returns: 1
while deq: # TC: O(N) total for this loop, which removes each starting element once
    deq.popleft() # TC: O(1) per removal
list(deq) # Returns: []

"""
Queue - Allocation & Basic Operations
"""
que = deque([1, 2, 3]) # FIFO queue
que.append(4) # TC: O(1) - State: [1, 2, 3, 4] => Enqueue
que.popleft() # TC: O(1) - Returns: 1, State: [2, 3, 4] => Dequeue
que[0] # TC: O(1) - Returns: 2 => Front

"""
Stack - Allocation & Basic Operations
"""
stk = deque([1, 2, 3]) # LIFO stack
stk.append(4) # TC: O(1) - State: [1, 2, 3, 4] => Push
stk.pop() # TC: O(1) - Returns: 4, State: [1, 2, 3] => Pop
stk[-1] # TC: O(1) - Returns: 3 => Peek

```

A deque can store the current elements or indices of a sliding window.
For character-uniqueness constraints, combine it with a set or character counts.
With a positive capacity `k`, `deque(maxlen=k)` discards the oldest item when `append()` adds to a full deque.
- [LeetCode 3. Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters)

Queues are used for BFS, which is covered in the graph chapter.
They can also expire old timestamped events from the front when events arrive in time order.
- [LeetCode 362. Design Hit Counter](https://leetcode.com/problems/design-hit-counter)

Stacks help parse nested structures.
They can also track extra state, such as the minimum so far, alongside each element.
- [LeetCode 20. Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [LeetCode 155. Min Stack](https://leetcode.com/problems/min-stack)

## Monotonic Deque / Queue

A monotonic deque keeps candidate indices ordered by their associated values.
For a sliding-window maximum, maintain nonincreasing values by removing dominated candidates from the back and expired indices from the front.
For a nonempty window, the front index identifies the current maximum.
For a minimum, reverse the value order.
Each index is appended and removed at most once, so a full pass over N inputs takes O(N) time.
- [LeetCode 239. Sliding Window Maximum](https://leetcode.com/problems/sliding-window-maximum)

## Monotonic Stack

A monotonic stack maintains candidate values, or indices referring to those values, in increasing or decreasing value order.
Pop from the top while an incoming value violates the chosen order.
During a single pass, each element is pushed once and popped at most once, giving O(N) total processing time.
- [LeetCode 496. Next Greater Element I](https://leetcode.com/problems/next-greater-element-i)
- [LeetCode 503. Next Greater Element II](https://leetcode.com/problems/next-greater-element-ii)
