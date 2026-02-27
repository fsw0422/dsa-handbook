# Linked List

You will encounter in most part, 2 kinds of questions for Linked List in interviews.

- Using a predefined singly-linked list node class.
  Note that these problems are generally solved with previous, current, next and temp pointers.

  ```typescript
  ...

  class ListNode<T> {
      val: T
      nxt: ListNode<T> | null

      constructor(val: T, nxt: ListNode<T> | null = null) {
          this.val = val
          this.nxt = nxt
      }
  }
  ```

  - [LeetCode 206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list)
- Using custom doubly-linked list that integrates with other data structures such as Map for building efficient data structures.

  ```typescript
  ...

  class ListNode<T> {
      val: T
      prv: ListNode<T> | null
      nxt: ListNode<T> | null

      constructor(val: T, prv: ListNode<T> | null = null, nxt: ListNode<T> | null = null) {
          this.val = val
          this.prv = prv
          this.nxt = nxt
      }
  }
  ```

  - [LeetCode 146. LRU Cache](https://leetcode.com/problems/lru-cache)

## Tips

- Dummy node:
  When using a dummy node, we don't need to check the corner case where the head is null.
  Definition of an empty list is now 'next node of head node equals null.
- Tail node:
  When you track the tail node, it's easier to append new nodes.
  Creating a new list as a result of another operation will be a good example.
  If the tail node is not given with the predefined list, you will have to at least traverse the entire list once, which makes the time complexity at least O(N).
  Tail node can also point to a dummy node to simplify code.
- Middle node:
  It is often asked in interviews of finding the middle node of a singly-linked list.
  It is useful when we have to break the list into 2, or moving 2 pointers in different speed.

Some solutions may use all three tips
- [LeetCode 148. sort-list](https://leetcode.com/problems/sort-list)
