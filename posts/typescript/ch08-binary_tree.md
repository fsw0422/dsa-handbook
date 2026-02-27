# Binary Tree

- Root Node:
  Node that is on the first level of the Binary Tree.
- Leaf Node:
  Nodes that do not have any children.
- Depth and Height:
  Height starts from leaf node, Depth starts from root node, thus height of a tree == maximum depth of subtree.

  ![image](/images/binary_tree/height_depth.png)

  - [LeetCode 110. Balanced Binary Tree](https://leetcode.com/problems/balanced-binary-tree)
- Various types of binary trees.

  ![image](/images/binary_tree/variants.png)

  Heap and Binary Search Tree are complete binary trees.
  Perfect Binary Tree contains `2^(h + 1) - 1` nodes and `2^h` leaf nodes.

## Traversal

Almost all Binary Tree problems are given a root node that represents the tree, and require various traversals.

```typescript
...

/*
N = number of Nodes in tree

TC: O(N)
SC: O(logN)
*/

class TreeNode<T> {
    val: T
    left: TreeNode<T> | null
    right: TreeNode<T> | null

    constructor(val: T, left: TreeNode<T> | null = null, right: TreeNode<T> | null = null) {
        this.val = val
        this.left = left
        this.right = right
    }
}


function inorderRecursive<T>(root: TreeNode<T> | null): T[] {
    const res: T[] = []

    function recurse(node: TreeNode<T> | null): void {
        if (node === null) return

        recurse(node.left)
        res.push(node.val)
        recurse(node.right)
    }

    recurse(root)
    return res
}


function inorderIterative<T>(root: TreeNode<T> | null): T[] {
    const res: T[] = []
    const stk: TreeNode<T>[] = []
    let cur = root
    while (stk.length > 0 || cur !== null) {
        while (cur !== null) {
            stk.push(cur)
            cur = cur.left
        }
        cur = stk.pop()!
        res.push(cur.val)
        cur = cur.right
    }
    return res
}


function preorderRecursive<T>(root: TreeNode<T> | null): T[] {
    const res: T[] = []

    function recurse(node: TreeNode<T> | null): void {
        if (node === null) return

        res.push(node.val)
        recurse(node.left)
        recurse(node.right)
    }

    recurse(root)
    return res
}


function preorderIterative<T>(root: TreeNode<T> | null): T[] {
    if (root === null) return []

    const res: T[] = []
    const stk: TreeNode<T>[] = []
    stk.push(root)
    while (stk.length > 0) {
        const cur = stk.pop()!
        res.push(cur.val)

        // Push right first so that left is processed first
        if (cur.right) stk.push(cur.right)
        if (cur.left) stk.push(cur.left)
    }
    return res
}


function postorderRecursive<T>(root: TreeNode<T> | null): T[] {
    const res: T[] = []

    function recurse(node: TreeNode<T> | null): void {
        if (node === null) return

        recurse(node.left)
        recurse(node.right)
        res.push(node.val)
    }

    recurse(root)
    return res
}


function postorderIterative<T>(root: TreeNode<T> | null): T[] {
    if (root === null) return []

    const res: T[] = []
    const stk: TreeNode<T>[] = []
    let cur: TreeNode<T> | null = root
    let last: TreeNode<T> | null = null
    while (stk.length > 0 || cur !== null) {
        if (cur !== null) {
            stk.push(cur)
            cur = cur.left
        } else {
            const peeked = stk[stk.length - 1]
            if (peeked.right && last !== peeked.right) {
                cur = peeked.right
            } else {
                res.push(peeked.val)
                last = stk.pop()!
            }
        }
    }
    return res
}


function levelOrder<T>(root: TreeNode<T> | null): T[] {
    if (root === null) return []

    const res: T[] = []
    const que: TreeNode<T>[] = []
    que.push(root)
    while (que.length > 0) {
        let size = que.length
        while (size > 0) {
            const polled = que.shift()!
            res.push(polled.val)
            if (polled.left) que.push(polled.left)
            if (polled.right) que.push(polled.right)
            size--
        }
    }
    return res
}
```

Problems often require you to construct / reconstruct a Binary Tree.
- [LeetCode 108. Convert Sorted Array to Binary Search Tree](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree)
- [LeetCode 226. Invert Binary Tree](https://leetcode.com/problems/invert-binary-tree)

In-order with either Pre-order or Post-order traversal, a unique Binary Tree can be constructed from a sorted Array.
- [LeetCode 105. Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal)

However, In-order alone or pre-order with post-order traversal cannot construct a unique Binary Tree.
- [LeetCode 889. Construct Binary Tree from Preorder and Postorder traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-postorder-traversal)

With the help of 'null' nodes marked as special characters, serialized representation of a Binary Tree can be derived from Pre-order or Post-order traversal.
- [LeetCode 572. Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree)
- [LeetCode 652. Find Duplicate Subtrees](https://leetcode.com/problems/find-duplicate-subtrees)

There is an In-order traversal algorithm called [Morris Inorder Traversal](https://www.youtube.com/watch?v=wGXB9OWhPTg) that uses O(1) space by using iteration without recursion or a stack.
