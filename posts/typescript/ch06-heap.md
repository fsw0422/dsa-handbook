# Heap

TypeScript does not have a built-in heap. Below is a minimal MinHeap implementation for interview use.

```typescript
...

class MinHeap<T> {
    private heap: T[] = []

    constructor(
        private compare: (a: T, b: T) => number = (a: any, b: any) => a - b
    ) {}

    get size(): number { return this.heap.length }

    peek(): T | undefined { return this.heap[0] }

    push(val: T): void {
        this.heap.push(val)
        this.bubbleUp(this.heap.length - 1)
    }

    pop(): T | undefined {
        if (this.heap.length === 0) return undefined
        const top = this.heap[0]
        const last = this.heap.pop()!
        if (this.heap.length > 0) {
            this.heap[0] = last
            this.sinkDown(0)
        }
        return top
    }

    private bubbleUp(i: number): void {
        while (i > 0) {
            const par = Math.floor((i - 1) / 2)
            if (this.compare(this.heap[i], this.heap[par]) >= 0) break
            ;[this.heap[i], this.heap[par]] = [this.heap[par], this.heap[i]]
            i = par
        }
    }

    private sinkDown(i: number): void {
        const n = this.heap.length
        while (true) {
            let smallest = i
            const l = 2 * i + 1
            const r = 2 * i + 2
            if (l < n && this.compare(this.heap[l], this.heap[smallest]) < 0) smallest = l
            if (r < n && this.compare(this.heap[r], this.heap[smallest]) < 0) smallest = r
            if (smallest === i) break
            ;[this.heap[i], this.heap[smallest]] = [this.heap[smallest], this.heap[i]]
            i = smallest
        }
    }
}

/*
Basic Operations
*/
const hp = new MinHeap<number>()
for (const num of [1, 4, 2, 5, 3]) hp.push(num) // TC: O(N * logN) to build by repeated insertion. O(N) heapify can be implemented separately
hp.push(0) // TC: O(logN)
hp.pop() // TC: O(logN)
hp.peek() // TC: O(1)

/*
For Max Heap, pass a reversed comparator
*/
const maxHp = new MinHeap<number>((a, b) => b - a)

/*
Top / Bottom K

TC: O(N * logK)
SC: O(K)
*/
function topK(nums: number[], k: number): number[] {
    // Uses min heap, so that every time the heap is full, we pop the smallest element
    const minHp = new MinHeap<number>()
    for (const num of nums) {
        minHp.push(num)
        if (minHp.size > k) {
            minHp.pop()
        }
    }

    const res: number[] = []
    while (minHp.size > 0) {
        res.push(minHp.pop()!)
    }
    return res
}


function bottomK(nums: number[], k: number): number[] {
    // Uses max heap, so that every time the heap is full, we pop the largest element
    const maxHp = new MinHeap<number>((a, b) => b - a)
    for (const num of nums) {
        maxHp.push(num)
        if (maxHp.size > k) {
            maxHp.pop()
        }
    }

    const res: number[] = []
    while (maxHp.size > 0) {
        res.push(maxHp.pop()!)
    }
    return res
}
```

Keep in mind that there is no point using Heap if you just throw all elements in it to find the top-K / bottom-K elements since it has no benefit over sort-and-iterate in terms of time / space complexity. Key is to keep the Heap size as 'K' by removing the next value after inserting a new element.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

Oftentimes, Heaps are used for quick access, update of min / max values while iterating an array.
- [LeetCode 253. Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii)
- [LeetCode 1438. Longest Continuous Subarray with Absolute Diff Less Than or Equal to Limit](https://leetcode.com/problems/longest-continuous-subarray-with-absolute-diff-less-than-or-equal-to-limit)
