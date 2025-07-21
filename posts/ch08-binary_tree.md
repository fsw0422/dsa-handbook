# Binary Tree

- _Root Node_:
  Node that is on the first level of the Binary Tree.
- _Leaf Node_:
  Nodes that do not have any children.
- _Depth_ and _Height_:
  Height starts from Leaf Node, Depth starts from Root Node, thus **height of a tree == maximum depth of subtree**.

  ![image](/images/binary_tree/height_depth.png)

  - [LeetCode 110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree)
- Various strains of Binary Trees.

  ![image](/images/binary_tree/variants.png)

  Heap and Binary Search Tree are Complete Binary Tree.
  Perfect Binary Tree contains `2^(h + 1) + 1` nodes and `2^h` Leaf Nodes.

## Traversal

Almost all Binary Tree problems are given a Root Node that represents the tree, and require various traversals.

```python
...

from typing import Any
from collections import deque


"""
N = number of Nodes in tree

TC: O(N)
SC: O(logN)
"""

class TreeNode:

    def __init__(self, val: Any, left: Optional['TreeNode'], right: Optional['TreeNode']):
        self.val = val
        self.left = left
        self.right = right
        
        
def inorder_recursive(root: TreeNode) -> list[Any]:
    res = list()

    def recurse(_root: TreeNode):
        if root is None:
            return
        
        recurse(_root.left)
        res.append(_root)
        recurse(_root.right)

    recurse(root)
    return res


def inorder_iterative(root: TreeNode) -> list[Any]:
    res = list()
    stk = deque()
    cur = root
    while stk or cur:
        while cur:
            stk.append(cur)
            cur = cur.left
        cur = stk.pop()
        res.append(cur)
        cur = cur.right
    return res 


def preorder_recursive(root: TreeNode) -> list[Any]:
    res = list()

    def recurse(_root: TreeNode):
        if _root is None:
            return

        res.append(_root)
        recurse(_root.left)
        recurse(_root.right)

    recurse(root)
    return res 


def preorder_iterative(root: TreeNode) -> list[Any]:
    if root is None:
        return list()

    res = list()
    stk = deque()
    stk.append(root)
    while stk:
        cur = stk.pop()
        res.append(cur.val)

        # Push right first so that left is processed first
        if cur.right:
            stk.append(cur.right)
        if cur.left:
            stk.append(cur.left)
    return res


def postorder_recursive(root: TreeNode) -> list[Any]:
    res = list()

    def recurse(_root: TreeNode):
        if root is None:
            return

        recurse(_root.left)
        recurse(_root.right)
        res.append(_root)

    recurse(root)
    return res


def postorder_iterative(root: TreeNode) -> list[Any]:
    if root is None:
        return list()

    res = list()
    stk = deque()
    cur = root 
    last = None
    while stk or cur:
        if cur:
            stk.append(cur)
            cur = cur.left
        else:
            peeked = stk[-1]
            if peeked.right and last != peeked.right:
                cur = peeked.right
            else:
                res.append(peeked)
                last = stk.pop()
    return res 

                
def level_order(root: TreeNode) -> list[Any]:
    res = list()
    que = deque()
    que.append(root)
    while que:
        size = len(que)
        while size > 0:
            polled = que.popleft()
            res.append(polled)
            if polled.left:
                que.append(polled.left)
            if polled.right:
                que.append(polled.right)
            size -= 1
    return res
```

Problems often require you to construct / reconstruct a Binary Tree.
- [LeetCode 108. Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree)
- [LeetCode 226. Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree)

In-order with either Pre-order or Post-order traversal, a unique Binary Tree can be constructed from a sorted List.
- [LeetCode 105. Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal)

However, In-order alone or Pre-order with Post-order traversal cannot construct a unique Binary Tree.
- [LeetCode 889. Construct Binary Tree from Preorder and Postorder traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-postorder-traversal)

With the help of 'null' nodes marked as special characters, serialized representation of a Binary Tree can be derived from Pre-order or Post-order traversal.
- [LeetCode 572. Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree)
- [LeetCode 652. Find Duplicate Subtrees](https://leetcode.com/problems/find-duplicate-subtrees)

There is an In-order traversal algorithm called [Morris Inorder Traversal](https://www.youtube.com/watch?v=wGXB9OWhPTg) that uses O(1) space by not using recursion or stack but iteration.
