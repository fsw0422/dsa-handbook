# Graph

- Vertex:
  Nodes in the Graph.
- Connected:
  Graph is considered Connected if every pair of vertices in the Graph is directly or indirectly reachable.
- Edge:
  Relation between vertices.
  Edges are always `vertices - 1` if the Graph is connected.
  Edges can be weighted (with both positive and negative values) and these Graphs are called weighted Graph.
  However, most problems in interviews will deal with non-weighted Graph.

## Categories & Must-Knows

- Undirected Graph:
  Graph that contains vertices with no direction.
  - Disjoint Set (Union Find):
    Data structure that groups vertices that are connected in Undirected Graph.

    ```python
    ...
    
    from typing import Any, Dict, Set
    
    
    class DisjointSet:
        def __init__(self, gph: Dict[Any, Set[Any]]):
            self.vtx_to_par = {vtx: vtx for vtx in gph.keys()}
            self.vtx_to_rnk = {vtx: 0 for vtx in gph.keys()}
            for vtx, nbrs in gph.items():
                for nbr in nbrs:
                    self.union(vtx, nbr)
    
        def union(self, vtx1: Any, vtx2: Any):
            par1 = self.find(vtx1)
            par2 = self.find(vtx2)
            if par1 != par2:
                if self.vtx_to_rnk[par1] > self.vtx_to_rnk[par2]:
                    self.vtx_to_par[par2] = par1
                elif self.vtx_to_rnk[par1] < self.vtx_to_rnk[par2]:
                    self.vtx_to_par[par1] = par2
                else:
                    self.vtx_to_par[par2] = par1
                    self.vtx_to_rnk[par1] += 1
    
        def find(self, vtx: Any) -> Any:
            par = self.vtx_to_par[vtx]
            if par != vtx:
                par = self.find(par)
                self.vtx_to_par[vtx] = par
            return par
    ```

    Also used for cycle detection in Undirected Graph.
    - [LeetCode 684. Redundant Connection](https://leetcode.com/problems/redundant-connection)
    - [LeetCode 685. Redundant Connection II](https://leetcode.com/problems/redundant-connection-ii)
- Directed Graph:
  Graph that contains vertices with direction.
  - Topological Sort:
    Ordering of the vertices where each edge is from the vertex earlier in the ordering to vertex later in the ordering.
    It represents the dependency graph of vertices (thus can detect cycles in Directed Graphs).

    ![topological_ordering](/images/graph/topological_ordering.png)

    ```python
    ...
    
    from typing import Any, Dict, Set, List, Deque
    from collections import defaultdict, deque
    
    
    def top_sort(gph: Dict[Any, Set[Any]]) -> List[Any]:
        """
        Using Khan's Algorithm
        """
    
        # Build-up all in-degree (edge that connects toward the vertex) counts of each vertex
        in_deg = defaultdict(int)
        for vtx in gph:
            for nbr in gph[vtx]:
                in_deg[nbr] += 1
    
        # Initialize queue with vertices that have in-degree of 0 (starting vertices)
        que = deque([vtx for vtx in gph if in_deg[vtx] == 0])
    
        # Remove in-degree one by one and add neighboring vertices only if there is no in-degree (meaning it turned into a start vertex) for the next process order
        top_sorted = list()
        while que:
            start = que.popleft()
            top_sorted.append(start)
            for nbr in gph[start]:
                in_deg[nbr] -= 1
                if in_deg[nbr] == 0:
                    que.append(nbr)
    
        # If a cycle exists, the queue will be empty earlier and terminate before adding everything to 'top-sorted'
        # For example, for graph 'A -> B -> A', initialized queue will be empty as there are no starting vertices in the first place
        if len(gph) > len(top_sorted):
            raise Exception('Cycle detected in graph')
    
        return top_sorted
    ```

    - [LeetCode 207. Course Schedule](https://leetcode.com/problems/course-schedule)
    - [LeetCode 269. Alien Dictionary](https://leetcode.com/problems/alien-dictionary)
  - Trie:
    Tree that is optimized for matching prefix of words.

    ![trie](/images/graph/trie.png)

    ```python
    ...
    
    class Trie:
        class _Node:
            def __init__(self):
                self.childs = dict()
                self.end = False
    
        def __init__(self):
            self._root = self._Node()
    
        def insert(self, txt: str):
            cur = self._root
            for ch in txt:
                if ch not in cur.childs:
                    cur.childs[ch] = self._Node()
                cur = cur.childs[ch]
            cur.end = True
    
        def start_with(self, pfx: str) -> bool:
            cur = self._root
            for ch in pfx:
                if ch not in cur.childs:
                    return False
                cur = cur.childs[ch]
            return True
    
        def longest_prefix(self) -> str:
            pfx = list()
            cur = self._root
            while len(cur.childs) == 1:
                for ch, _ in cur.childs:
                    if ch not cur.end:
                        pref.append(ch)
                        cur = cur.childs[ch]
                    else:
                        return ''.join(pfx)
            return ''.join(pfx)
    ```

    - [LeetCode 208. Implement Trie](https://leetcode.com/problems/implement-trie-prefix-tree)
    - [LeetCode 14. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix)

## Representation

- Adjacency Matrix:
  Represents the Graph in N x N matrix.

  ![adjmatrix](/images/graph/adj_matrix.png)

  - [LeetCode 1615. Maximal Network rnk](https://leetcode.com/problems/maximal-network-rank)
- Adjacency Set:
  Represents mapping of vertex -> set of neighboring vertices.

  ```python
  ...
  
  gph = {
      'a': {'b', 'c', 'd'},
      'b': {'e', 'f'},
  }
  ```

Sometimes, only edges are given so we need to build the graph from scratch.
You can build the graph in either way.

## Search

- Depth First Search (DFS):
  Recursion is used for implementation.
  In fact, DFS is a generalization of Pre / Post / In-order traversals of binary tree in the previous chapter (as Graph is also one form of generalization of a N-ary tree)

  ```python
  from typing import Any, Dict, Set, List
  from collections import deque
  
  
  def dfs(gph: Dict[Any, Set[Any]], start: Any) -> List[Any]:
      """
      TC: O(|V| + |E|)
      SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
      """
  
      res = list()
      seen = set()
  
      def recurse(vtx: Any):
          if vtx in seen:
              return
  
          seen.add(vtx)
          res.append(vtx)
          for nbr in gph[vtx]:
              recurse(nbr)
  
      def iterate(vtx: Any):
          stk = deque()
          seen.add(vtx)
          stk.append(vtx)
          while stk:
              cur = stk.pop()
              res.append(cur)
              for nbr in gph[cur]:
                  if nbr in seen:
                      continue
  
                  seen.add(nbr)
                  stk.append(nbr)
  
      recurse(start)
      #iterate(start)
      return res
  ```

  - [LeetCode 200. Number of Islands](https://leetcode.com/problems/number-of-islands)
- Breadth First Search (BFS):
  Queue is used for implementation.
  Used to find the shortest path between 2 vertices, minimal steps to reach a target, etc.
  In fact, BFS is a generalization of Level-order traversal of binary tree in the previous chapter (as Graph is also one form of generalization of a N-ary tree)

  ```python
  ...
  
  from typing import Any, Dict, Set, List
  from collections import deque
  
  
  def bfs(gph: Dict[Any, Set[Any]], start: Any) -> List[Any]:
      """
      TC: O(|V| + |E|)
      SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
      """
  
      res = list()
      seen = set()
  
      que = deque()
      seen.add(start)
      que.append(start)
      while que:
          cur = que.popleft()
          res.append(cur)
          for nbr in gph[cur]:
              if nbr in seen:
                  continue
  
              seen.add(nbr)
              que.append(nbr)
      return res
  ```

  - [LeetCode 934. Shortest Bridge](https://leetcode.com/problems/shortest-bridge)
  - [LeetCode 322. Coin Change](https://leetcode.com/problems/coin-change)

## Advanced Graph Topics

These are advanced graph topics.
Please learn only if you have enough time until interviews.

[Dijkstra](https://www.youtube.com/watch?v=lAXZGERcDf4&t=21s) & [Bellman-Ford](https://www.youtube.com/watch?v=-mOEd_3gTK0)
- [LeetCode 787. Cheapest Flights Within K Stops](https://leetcode.com/problems/cheapest-flights-within-k-stops)

[A\*](https://www.youtube.com/watch?v=vP5TkF0xJgI&t=99s)
- [LeetCode 1091. Shortest Path in Binary Matrix](https://leetcode.com/problems/shortest-path-in-binary-matrix)

Minimum Spanning Trees:
Tree where the sum of all edge weights are minimum by picking the edges in Greedy manner.
In general, the algorithm is designed toward weighted graph.
However, for non-weighted graphs, it just means the minimum count of edges.
[Kruskal's Minimum Spanning Tree](https://www.youtube.com/watch?v=fAuF0EuZVCk) (For undirected graph) & [Prim's Minimum Spanning Tree](https://www.youtube.com/watch?v=oP2-8ysT3QQ) (For directed graph) are examples.
- [LeetCode 1584. Min Cost to Connect All Points](https://leetcode.com/problems/min-cost-to-connect-all-points)
