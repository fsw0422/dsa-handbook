# Heap

We will be using [@datastructures-js/heap](https://datastructures-js.info/docs/heap) which provides performant, type-safe `MinHeap` and `MaxHeap` implementations.

```typescript
...

import { MinHeap, MaxHeap, Heap } from '@datastructures-js/heap';


/**
 * Basic Operations
 */
const hp = new MinHeap<number>(null, [1, 4, 2, 5, 3]); // TC: O(N) => Auto-heapified
hp.push(0); // TC: O(logN) - pushes 0
hp.extractRoot(); // TC: O(logN) - removes and returns smallest => also aliased as `.pop()`
hp.root(); // TC: O(1) - returns smallest without removing
hp.size(); // TC: O(1)
hp.isEmpty(); // TC: O(1)

// MaxHeap for primitives
const maxHp = new MaxHeap<number>(null, [1, 4, 2, 5, 3]); // TC: O(N) - Auto-heapified
maxHp.root(); // TC: O(1) - Returns: 5

// Custom Heap with compare function (for objects or custom ordering)
const customHp = new Heap<{ id: number; val: number }>(
    (a, b) => a.val - b.val // min heap by 'val'
);

/**
 * Top / Bottom K
 *
 * TC: O(N * logK)
 * SC: O(K)
 */
function topK(nums: number[], k: number): number[] {
    /**
    * Uses min heap, so that every time the heap is full, we pop the smallest element
     */
    const minHp = new MinHeap<number>();
    for (const num of nums) {
        minHp.push(num);
        if (minHp.size() > k) {
            minHp.pop();
        }
    }

    const res: number[] = [];
    while (!minHp.isEmpty()) {
        res.push(minHp.pop()!);
    }
    return res;
}

function bottomK(nums: number[], k: number): number[] {
    /**
    * Uses max heap, so that every time the heap is full, we pop the largest element
     */
    const maxHp = new MaxHeap<number>();
    for (const num of nums) {
        maxHp.push(num);
        if (maxHp.size() > k) {
            maxHp.pop();
        }
    }

    const res: number[] = [];
    while (!maxHp.isEmpty()) {
        res.push(maxHp.pop()!);
    }
    return res;
}
```

Keep in mind that there is no point using Heap if you just throw all elements in it to find the top-K / bottom-K elements since it has no benefit over sort-and-iterate in terms of time / space complexity. Key is to keep the Heap size as 'K' by removing the next value after inserting a new element.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

Oftentimes, Heaps are used for quick access, update of min / max values while iterating an array.
- [LeetCode 253. Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)
- [LeetCode 1438. Longest Continuous Subarray with Absolute Diff Less Than or Equal to Limit](https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit)
