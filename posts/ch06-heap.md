# Heap

```python
...

import heapq
from typing import List


"""
Basic Operations
"""
heap = [1, 4, 2, 5, 3]
heapq.heapify(heap) # TC: O(N) - Amortized (not O(N * logN))
heapq.heappush(heap, 0) # TC: O(logN) - [0, 1, 4, 2, 5, 3]
val = heapq.heappop(heap) # TC: O(logN) - [1, 3, 2, 5, 4]
peek = heap[0] # TC: O(1)

"""
Top / Bottom K

TC: O(N * logK)
SC: O(K)
"""
def top_k(nums: List[int], k: int) -> List[int]:
    """
    Uses min heap, so that everytime the heap is full, we pop from the smallest element
    """

    min_heap = list()
    for num in nums:
        heapq.heappush(min_heap, num)
        if len(min_heap) > k:
            heapq.heappop(min_heap)

    res = list()
    while len(min_heap) > 0:
        res.append(heapq.heappop(min_heap))
    return res


def bottom_k(nums: List[int], k: int) -> List[int]:
    """
    Uses max heap, so that everytime the heap is full, we pop from the largest element
    """

    max_heap = list()
    for num in nums:
        heapq.heappush(max_heap, -num)
        if len(max_heap) > k:
            heapq.heappop(max_heap)

    res = list()
    while len(max_heap) > 0:
        res.append(-heapq.heappop(max_heap))
    return res
```

Keep in mind that there is no point using Heap if you just throw all elements in it to find the top-K / bottom-K elements since it has no benefit over sort-and-iterate in terms of time / space complexity. Key is to keep the Heap size as 'K' by removing the next value after inserting a new element.

[LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

Oftentimes, Heaps are used for quick access, update of min / max values while iterating a list.

[LeetCode 253. Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)

[LeetCode 1438. Longest Continuous Subarray with Absolute Diff Less Than or Equal to Limit](https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit)
