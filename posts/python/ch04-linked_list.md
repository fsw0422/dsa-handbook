# Linked List

Interview questions about linked lists commonly fall into two categories.

- Working with a predefined singly linked list node class.
  These problems often involve tracking the previous, current, and next nodes while updating links.
  Use the attributes defined by the question; the example below uses 'nxt', while some platforms use 'next'.

  ```python
  from __future__ import annotations

  from typing import Any, Optional
  

  class ListNode:
      def __init__(self, val: Any, nxt: Optional[ListNode] = None):
          self.val = val
          self.nxt = nxt
  ```

  - [LeetCode 141. Linked List Cycle](https://leetcode.com/problems/linked-list-cycle)
- Building a custom doubly linked list and combining it with other data structures, such as a dictionary.
  An LRU cache uses a dictionary to find nodes and a doubly linked list to track recency.
  A doubly linked list can remove a known node in O(1) time by updating its neighbors.

  ```python
  from __future__ import annotations

  from typing import Any, Optional


  class DoublyListNode:
      def __init__(self, val: Any, prv: Optional[DoublyListNode] = None, nxt: Optional[DoublyListNode] = None):
          self.val = val
          self.prv = prv
          self.nxt = nxt
  ```

  - [LeetCode 146. LRU Cache](https://leetcode.com/problems/lru-cache)

## Tips

- Dummy head:
  A dummy head provides a stable predecessor for the first real node, reducing special cases when inserting or deleting the head.
  The actual head is 'dummy.nxt', and the list is empty when 'dummy.nxt is None'.
- Tail pointer:
  Tracking the last node lets you append new nodes in O(1) time, which is useful when building a list.
  If only the head is available, finding the tail takes O(N) time.
  When building a list with a dummy head, initialize the tail to the dummy node while the list is empty.
- Middle node:
  Use slow and fast pointers to find the middle of a singly linked list in O(N) time and O(1) auxiliary space.
  Advance the slow pointer by one node and the fast pointer by two nodes.
  For an even-length list, decide whether the problem needs the first or second middle node.
  Finding the middle is useful when splitting a list, such as for merge sort.
- Pointer updates:
  Save the next node before overwriting the current node's 'nxt' link so you do not lose access to the rest of the list.
  In a doubly linked list, update both the 'prv' and 'nxt' links when inserting or removing nodes.

Some solutions combine dummy heads, tail pointers, and middle-node searches.
- [LeetCode 148. Sort List](https://leetcode.com/problems/sort-list)
