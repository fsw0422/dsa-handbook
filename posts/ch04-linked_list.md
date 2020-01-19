# Linked List

You will encounter in most part, 2 kinds of questions for Linked List in interviews.

- Using a predefined **singly-linked list** node class.
  Note that these problems are generally solved with previous, current, next and temp pointers.

    ```python
    ...
  
    from typing import Any
  
    class ListNode:
        
        def __init__(self, val: Any, next_: 'ListNode'):
            self.val = val
            self.next = next_
    ```

    [LeetCode 206. Reverse Linked List](https://leetcode.com/problems/reverse-linked-list)

- Using custom **doubly-linked list** that integrates with other data structures such as Dictionary for building efficient data structures.

    ```python
    ...
    
    from typing import Any
    
    class ListNode:
        
        def __init__(self, val: Any, prev: 'ListNode', next_: 'ListNode'):
            self.val = val
            self.next = next_
            self.prev = prev
    ```

    [LeetCode 146. LRU Cache](https://leetcode.com/problems/lru-cache)

## Tips

- _Dummy node_:
  When using a dummy node, we don't need to check the corner case where the head is null.
  Definition of an empty list is now **Next node of head node is null**.

- _Tail node_:
  When you track the tail node, it's easier to append new nodes.
  Creating a new list as a result of another operation will be a good example.
  If the tail node is not given with the predefined list, you will have to at least traverse the entire list once, which makes the time complexity at least O(N).
  Tail node can also point to a dummy node to simplify code.

- _Middle node_:
  It is often asked in interviews of finding the middle node of a singly-linked list.
  It is useful when we have to break the list into 2, or moving 2 pointers in different speed.

[LeetCode 148. sort-list](https://leetcode.com/problems/sort-list) contains solutions that have all of these tips
