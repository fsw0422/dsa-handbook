# Deque / Stack / Queue

TypeScript does not have a built-in deque. Arrays can be used for Stack (efficient `push`/`pop`) and Queue (though `shift` is O(N)).
For performance-critical Queue/Deque implementations, a doubly-linked list or circular buffer should be used.

We will be using Arrays for both Stack / Queue as they contain all operations needed for interview purposes.

```typescript
...

/*
Queue - Allocation & Basic Operations

For interview purposes, using an array with 'push' and 'shift' is acceptable.
Note: 'shift()' is O(N). For true O(1) dequeue, implement a linked-list-based queue.
*/
const que: number[] = [1, 2, 3]
que.push(4) // TC: O(1) - State: [1, 2, 3, 4] => Enqueue
que.shift() // TC: O(N) - Returns: 1, State: [2, 3, 4] => Dequeue
que[0] // TC: O(1) - Returns: 2 => Front

if (que.length > 0) { ... } // If queue is not empty => Mostly used in queues as items are added / removed frequently
while (que.length > 0) { ... } // While queue is not empty => Mostly used in queues as items are added / removed frequently

/*
Stack - Allocation & Basic Operations
*/
const stk: number[] = [1, 2, 3]
stk.push(4) // TC: O(1) - State: [1, 2, 3, 4] => Push
stk.pop() // TC: O(1) - Returns: 4, State: [1, 2, 3] => Pop
stk[stk.length - 1] // TC: O(1) - Returns: 3 => Peek
stk.at(-1) // TC: O(1) - Returns: 3 => Peek (alternative)

if (stk.length > 0) { ... } // If stack is not empty
while (stk.length > 0) { ... } // While stack is not empty

/*
Deque - Using a simple linked-list-based implementation for O(1) operations on both ends
*/
class Deque<T> {
    private head: { val: T, prv: any, nxt: any } | null = null
    private tail: { val: T, prv: any, nxt: any } | null = null
    private _size: number = 0

    get size(): number { return this._size }

    pushBack(val: T): void {
        const node = { val, prv: this.tail, nxt: null }
        if (this.tail) this.tail.nxt = node
        else this.head = node
        this.tail = node
        this._size++
    }

    pushFront(val: T): void {
        const node = { val, prv: null, nxt: this.head }
        if (this.head) this.head.prv = node
        else this.tail = node
        this.head = node
        this._size++
    }

    popBack(): T | undefined {
        if (!this.tail) return undefined
        const val = this.tail.val
        this.tail = this.tail.prv
        if (this.tail) this.tail.nxt = null
        else this.head = null
        this._size--
        return val
    }

    popFront(): T | undefined {
        if (!this.head) return undefined
        const val = this.head.val
        this.head = this.head.nxt
        if (this.head) this.head.prv = null
        else this.tail = null
        this._size--
        return val
    }

    peekFront(): T | undefined { return this.head?.val }
    peekBack(): T | undefined { return this.tail?.val }
}
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
