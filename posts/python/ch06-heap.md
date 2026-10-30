# Heap

Python's `heapq.heapify()`, `heappush()`, and `heappop()` maintain a min-heap in a list.
Each parent is less than or equal to its children, so `hp[0]` is the smallest value.
The remaining elements are not necessarily sorted.
Reading the root or calling `heappop()` on an empty heap raises `IndexError`.

Python 3.14 added [max-heap helpers](https://docs.python.org/3/library/heapq.html#heapq.heapify_max), including `heapify_max()`, `heappush_max()`, and `heappop_max()`.
The examples below negate integers to simulate a max-heap on older Python versions too.

```python
...

import heapq as hpq
from typing import List


"""
Basic Operations
"""
hp = [1, 4, 2, 5, 3]
hpq.heapify(hp) # TC: O(N) worst case - State: [1, 3, 2, 5, 4]
hpq.heappush(hp, 0) # TC: O(logN) - State: [0, 3, 1, 5, 4, 2]
hpq.heappop(hp) # TC: O(logN) - Returns: 0, State: [1, 3, 2, 5, 4]
hp[0] # TC: O(1) - Returns: 1

"""
Top / Bottom K

For k > 0, let N = len(nums) and K = min(k, N).
TC: O(N * log(K + 1))
SC: O(K) auxiliary space, plus O(K) for the returned list.
For k == 0, both functions return immediately.
"""
def top_k(nums: List[int], k: int) -> List[int]:
    """
    Return up to k largest values in ascending order.
    Keep a min-heap and remove its smallest value whenever its size exceeds k.
    """

    if k < 0:
        raise ValueError("k must be nonnegative")
    if k == 0:
        return []

    min_hp = list()
    for num in nums:
        hpq.heappush(min_hp, num)
        if len(min_hp) > k:
            hpq.heappop(min_hp)

    res = list()
    while min_hp:
        res.append(hpq.heappop(min_hp))
    return res


def bottom_k(nums: List[int], k: int) -> List[int]:
    """
    Return up to k smallest values in descending order.
    Negate integers to simulate a max-heap and remove the largest value when its size exceeds k.
    """

    if k < 0:
        raise ValueError("k must be nonnegative")
    if k == 0:
        return []

    max_hp = list()
    for num in nums:
        hpq.heappush(max_hp, -num)
        if len(max_hp) > k:
            hpq.heappop(max_hp)

    res = list()
    while max_hp:
        res.append(-hpq.heappop(max_hp))
    return res


# Library helpers take k and an iterable, returning a sorted list.
hpq.nlargest(3, [3, 1, 4, 2, 5]) # Returns: [5, 4, 3] => Descending
hpq.nsmallest(3, [3, 1, 4, 2, 5]) # Returns: [1, 2, 3] => Ascending

top_k([3, 1, 4, 2, 5], 3) # Returns: [3, 4, 5]
bottom_k([3, 1, 4, 2, 5], 3) # Returns: [3, 2, 1]
```

Both functions retain duplicates and leave the input list unchanged.
If `k` exceeds the input length, they return all values in the documented order.
Negative `k` raises `ValueError`.

A bounded heap keeps at most K candidates after each iteration, limiting auxiliary space to O(K).
The examples briefly hold one extra value before removing it.
The result order comes from repeatedly popping the retained heap.

Building a heap from all N values can also be useful.
For the K smallest values, `heapify()` followed by K pops takes O(N + K * logN) time, which can beat sorting when K is small.
Heapifying the input changes it; copying it first uses O(N) extra space.
Python also provides [`nlargest()` and `nsmallest()`](https://docs.python.org/3/library/heapq.html#heapq.nlargest) to select extreme values directly.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

Heaps are useful when processing changing data and repeatedly retrieving the smallest or largest value.
Push and pop operations preserve the heap order.
Changing an entry in place can break the heap order.
To update a priority, rebuild the heap or insert a replacement and mark the old entry as stale so it can be skipped when popped.
For sliding windows, store indices alongside values so expired entries can be recognized when they reach the root.
Expired entries can remain below the root, so this approach does not guarantee O(K) space for a window of size K.
- [LeetCode 253. Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)
- [LeetCode 1438. Longest Continuous Subarray with Absolute Diff Less Than or Equal to Limit](https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit)
