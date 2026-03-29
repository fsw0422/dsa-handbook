# Heap

```python
...

import heapq as hpq
from typing import List


"""
Basic Operations
"""
hp = [1, 4, 2, 5, 3]
hpq.heapify(hp) # TC: O(N) - Amortized (not O(N * logN))
hpq.heappush(hp, 0) # TC: O(logN) - State: [0, 1, 4, 2, 5, 3]
hpq.heappop(hp) # TC: O(logN) - State: [1, 3, 2, 5, 4]
hp[0] # TC: O(1)

"""
Top / Bottom K

TC: O(N * logK)
SC: O(K)
"""
def top_k(nums: List[int], k: int) -> List[int]:
    """
    Uses min heap, so that every time the heap is full, we pop the smallest element
    """

    min_hp = list()
    for num in nums:
        hpq.heappush(min_hp, num)
        if len(min_hp) > k:
            hpq.heappop(min_hp)

    res = list()
    while len(min_hp) > 0:
        res.append(hpq.heappop(min_hp))
    return res


def bottom_k(nums: List[int], k: int) -> List[int]:
    """
    Uses max heap, so that every time the heap is full, we pop the largest element
    """

    max_hp = list()
    for num in nums:
        hpq.heappush(max_hp, -num)
        if len(max_hp) > k:
            hpq.heappop(max_hp)

    res = list()
    while len(max_hp) > 0:
        res.append(-hpq.heappop(max_hp))
    return res
```

Keep in mind that there is no point using Heap if you just throw all elements in it to find the top-K / bottom-K elements since it has no benefit over sort-and-iterate in terms of time / space complexity. Key is to keep the Heap size as 'K' by removing the next value after inserting a new element.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

Oftentimes, Heaps are used for quick access, update of min / max values while iterating a list.
- [LeetCode 253. Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)
- [LeetCode 1438. Longest Continuous Subarray with Absolute Diff Less Than or Equal to Limit](https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit)
