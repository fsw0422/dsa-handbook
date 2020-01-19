# Binary Tree

- _Root Node_:
  Node that is on the first level of the Binary Tree.

- _Leaf Node_:
  Nodes that do not have any children.

- _Depth_ and _Height_:
  Height starts from Leaf Node, Depth starts from Root Node, thus **height of a tree == maximum depth of subtree**.

    ![image](/images/binary_tree/height_depth.png)

    [LeetCode 110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree)

- Various strains of Binary Trees.

    ![image](/images/binary_tree/variants.png)

    Heap and Binary Search Tree are Complete Binary Tree.

    Perfect Binary Tree contains `2^(h + 1) + 1` nodes and `2^h` Leaf Nodes.

## Traversal

Almost all Binary Tree problems are given a Root Node that represents the tree, and require various traversals.

```python
...

from typing import Any, List
from collections import deque


"""
N = number of Nodes in tree

TC: O(N)
SC: O(logN)
"""

class TreeNode:

    def __init__(self, val: Any, left: "TreeNode", right: "TreeNode"):
        self.val = val
        self.left = left
        self.right = right
        
        
def inorder_recursive(tree_node: TreeNode) -> List[Any]:
    collected = list()

    def recurse(root: TreeNode):
        if root is None:
            return
        recurse(root.left)
        collected.append(root)
        recurse(root.right)

    recurse(tree_node)
    return collected


def inorder_iterative(tree_node: TreeNode) -> List[Any]:
    stack = deque()
    collected = list()
    cur = tree_node
    while stack or cur:
        while cur:
            stack.append(cur)
            cur = cur.left
        cur = stack.pop()
        collected.append(cur)
        cur = cur.right
    return collected


def preorder_recursive(tree_node: TreeNode) -> List[Any]:
    collected = list()

    def recurse(root: TreeNode):
        if root is None:
            return

        collected.append(root)
        recurse(root.left)
        recurse(root.right)

    recurse(tree_node)
    return collected


def preorder_iterative(tree_node: TreeNode) -> List[Any]:
    if tree_node is None:
        return list()

    stack = deque()
    collected = list()
    stack.append(tree_node)
    while stack:
        cur = stack.pop()
        collected.append(cur.val)

        # Push right first so that left is processed first
        if cur.right:
            stack.append(cur.right)
        if cur.left:
            stack.append(cur.left)
    return collected


def postorder_recursive(tree_node: TreeNode) -> List[Any]:
    collected = list()

    def recurse(root: TreeNode):
        if root is None:
            return

        recurse(root.left)
        recurse(root.right)
        collected.append(root)

    recurse(tree_node)
    return collected


def postorder_iterative(tree_node: TreeNode) -> List[Any]:
    if tree_node is None:
        return list()

    stack = deque()
    collected = list()
    cur = tree_node 
    last_collected = None

    while stack or cur:
        if cur:
            stack.append(cur)
            cur = cur.left
        else:
            peek_node = stack[-1]
            if peek_node.right and last_collected != peek_node.right:
                cur = peek_node.right
            else:
                collected.append(peek_node)
                last_collected = stack.pop()
    return collected

                
def level_order(root: TreeNode) -> List[Any]:
    queue = deque()
    collected = list()
    queue.append(root)
    while queue:
        size = len(queue)
        while size > 0:
            polled = queue.popleft()
            if polled.left:
                queue.append(polled.left)
                collected.append(polled.left)
            if polled.right:
                queue.append(polled.right)
                collected.append(polled.right)
            size -= 1

    return collected
```

- Problems often require you to construct / reconstruct a Binary Tree.

    [LeetCode 108. Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree)

    [LeetCode 226. Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree)

- In-order with either Pre-order or Post-order traversal, a unique Binary Tree can be constructed from a sorted List.

    [LeetCode 105. Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal)

    However, In-order alone or Pre-order with Post-order traversal cannot construct a unique Binary Tree.

    [LeetCode 889. Construct Binary Tree from Preorder and Postorder traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-postorder-traversal)

- With the help of 'null' nodes marked as special characters, serialized representation of a Binary Tree can be derived from Pre-order or Post-order traversal.

    [LeetCode 572. Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree)

    [LeetCode 652. Find Duplicate Subtrees](https://leetcode.com/problems/find-duplicate-subtrees)

- There is an In-order traversal algorithm called [Morris Inorder Traversal](https://www.youtube.com/watch?v=wGXB9OWhPTg) that uses O(1) space by not using recursion or stack but iteration.
