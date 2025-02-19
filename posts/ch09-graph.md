# Graph

- _Vertex_:
  Nodes in the Graph.

- _Connected_:
  Graph is considered **Connected** if every pair of vertices in the Graph is directly or indirectly reachable.

- _Edge_:
  Relation between vertices.
  Edges are always `vertices - 1` if the Graph is connected.
  Edges can be weighted (with both positive and negative values) and these Graphs are called **weighted** Graph.
  However, most problems in interviews will deal with **non-weighted** Graph.

## Categories & Must-Knows

- _Undirected Graph_:
  Graph that contains vertices with no direction.

    - _Disjoint Set (Union Find)_:
      Data structure that group vertices that are connected in Undirected Graph.
    
        ```python
        ...
      
        from typing import Any, Dict, Set
    
    
        class DisjointSet:
    
            def __init__(self, graph: Dict[Any, Set[Any]]):
                self.vtx_to_parent = {vtx: vtx for vtx in graph.keys()}
                self.vtx_to_rank = {vtx: 0 for vtx in graph.keys()}
                for vtx, nbrs in graph.items():
                    for nbr in nbrs:
                        self.union(vtx, nbr)
    
            def union(self, vtx1: Any, vtx2: Any):
                parent1 = self.find(vtx1)
                parent2 = self.find(vtx2)
                if parent1 != parent2:
                    if self.vtx_to_rank[parent1] > self.vtx_to_rank[parent2]:
                        self.vtx_to_parent[parent2] = parent1
                    elif self.vtx_to_rank[parent1] < self.vtx_to_rank[parent2]:
                        self.vtx_to_parent[parent1] = parent2
                    else:
                        self.vtx_to_parent[parent2] = parent1
                        self.vtx_to_rank[parent1] += 1
    
            def find(self, vtx: Any) -> Any:
                parent = self.vtx_to_parent[vtx]
                if parent != vtx:
                    parent = self.find(parent)
                    self.vtx_to_parent[vtx] = parent
                return parent
        ```
    
      Also used for cycle detection in Undirected Graph.
    
      [LeetCode 684. Redundant Connection](https://leetcode.com/problems/redundant-connection)
    
      [LeetCode 685. Redundant Connection II](https://leetcode.com/problems/redundant-connection-ii)

- _Directed Graph_:
  Graph that contains vertices with direction.

    - _Topological Sort_:
      Ordering of the vertices where each edge is from the *vertex earlier in the ordering* to *vertex later in the ordering*.
      It represents the dependency Graph of vertices (thus can detect cycles in Directed Graphs).

        ![topological_ordering](/images/graph/topological_ordering.png)

        ```python
        ...
      
        from typing import Any, Dict, Set, List, Deque
        from collections import defaultdict, deque


        def topsort(graph: Dict[Any, Set[Any]]) -> List[Any]:
            """
            Using Khan's Algorithm
            """

            # Build-up all in-degree (edge that connects toward the vertex) counts of each vertex
            in_degree = defaultdict(int)
            for vtx in graph:
                for nbr in graph[vtx]:
                    in_degree[nbr] += 1

            # Initialize queue with vertices that have in-degree of 0 (starting vertices)
            que = deque([vtx for vtx in graph if in_degree[vtx] == 0])

            # Remove in-degree one-by-one and add neighbouring vertices only if there is no in-degree (meaning it turned into start vertice) for next process order
            top_sorted = list()
            while que:
                start = que.popleft()
                top_sorted.append(start)
                for nbr in graph[start]:
                    in_degree[nbr] -= 1
                    if in_degree[nbr] == 0:
                        que.append(nbr)

            # If cycle exist, queue will be empty earlier and terminate before adding everything to 'top-sorted'
            # For example, for graph 'A -> B -> A', initialized queue will be empty as there are no starting vertices in the first place
            if len(graph) > len(top_sorted):
                raise Exception('Cycle detected in graph')

            return top_sorted
        ```

        [LeetCode 207. Course Schedule](https://leetcode.com/problems/course-schedule)

        [LeetCode 269. Alien Dictionary](https://leetcode.com/problems/alien-dictionary)

    - _Trie_:
      Tree that is optimized for matching prefix of words.

        ![trie](/images/graph/trie.png)

        ```python
        ...
      
        class Trie:

            class _Node:

                def __init__(self):
                    self.children = dict()
                    self.end = False

            def __init__(self):
                self._root = self._Node()

            def insert(self, word: str):
                cur = self._root
                for ch in word:
                    if ch not in cur.children:
                        cur.children[ch] = self._Node()
                    cur = cur.children[ch]
                cur.end = True

            def start_with(self, prefix: str) -> bool:
                cur = self._root
                for ch in prefix:
                    if ch not in cur.children:
                        return False
                    cur = cur.children[ch]
                return True

            def longest_prefix(self) -> str:
                prefix = list()
                cur = self._root
                while len(cur.children) == 1:
                    for ch, _ in cur.children:
                        if ch not cur.end:
                            prefix.append(ch)
                            cur = cur.children[ch]
                        else:
                            return ''.join(prefix)
                return ''.join(prefix)
        ```

        [LeetCode 208. Implement Trie](https://leetcode.com/problems/implement-trie-prefix-tree)

        [LeetCode 14. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix)

## Representation

- _Adjacency Matrix_:
  Represents the Graph in N x N matrix.

    ![adjmatrix](/images/graph/adj_matrix.png)

    [LeetCode 1615. Maximal Network Rank](https://leetcode.com/problems/maximal-network-rank)

- _Adjacency Set_:
  Represents mapping of vertex -> set of neighboring vertices.

    ```python
    ...
  
    graph = {
      'a': {'b', 'c', 'd'},
      'b': {'e', 'f'},
    }
    ```

Sometimes, only edges are given so we need to build the Graph from scratch.
You can build the Graph in either way.

## Search

- _Depth First Search (DFS)_:
  Recursion is used for implementation.
  In fact, DFS is a generalization of Pre / Post / In-order traversals of Binary Tree in previous chapter (as Graph is also one form of generalization of a N-ary Tree)

    ```python
    from typing import Any, Dict, Set, List
    from collections import deque


    def dfs(graph: Dict[Any, Set[Any]], start_vtx: Any) -> List[Any]:
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
            for nbr in graph[vtx]:
                recurse(nbr)

        def iterate(vtx: Any):
            stk = deque()
            seen.add(start_vtx)
            stk.append(start_vtx)
            while stk:
                cur = stk.pop()
                res.append(cur)
                for nbr in graph[cur]:
                    if nbr in seen:
                        continue

                    seen.add(nbr)
                    stk.append(nbr)

        recurse(start_vtx)
        #iterate(start_vtx)
        return res 
    ```

    [LeetCode 200. Number of Islands](https://leetcode.com/problems/number-of-islands)

- _Breadth First Search (BFS)_:
  Queue is used for implementation.
  Used for find the shortest path between 2 vertices, minimal steps to reach a target etc. 
  In fact, BFS is a generalization of Level-order traversal of Binary Tree in previous chapter (as Graph is also one form of generalization of a N-ary Tree)

    ```python
    ...
  
    from typing import Any, Dict, Set, List
    from collections import deque


    def bfs(graph: Dict[Any, Set[Any]], start_vtx: Any) -> List[Any]:
        """
        TC: O(|V| + |E|)
        SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
        """

        res = list()
        seen = set()

        que = deque()
        seen.add(start_vtx)
        que.append(start_vtx)
        while que:
            cur = que.popleft()
            res.append(cur)
            for nbr in graph[cur]:
                if nbr in seen:
                    continue
  
                seen.add(nbr)
                que.append(nbr)
        return res
    ```

    [LeetCode 934. Shortest Bridge](https://leetcode.com/problems/shortest-bridge)

    [LeetCode 322. Coin Change](https://leetcode.com/problems/coin-change)

## Advanced Graph Topics

These are advanced Graph topics.
Please learn only if you have enough time until interviews.

- [_Djikstra_](https://www.youtube.com/watch?v=lAXZGERcDf4&t=21s) & [_Bellmanford_](https://www.youtube.com/watch?v=-mOEd_3gTK0)

  [LeetCode 787. Cheapest Flights Within K Stops](https://leetcode.com/problems/cheapest-flights-within-k-stops)

- [_A\*_](https://www.youtube.com/watch?v=vP5TkF0xJgI&t=99s)

  [LeetCode 1091. Shortest Path in Binary Matrix](https://leetcode.com/problems/shortest-path-in-binary-matrix)

- _Minimum Spanning Tree_:
  Tree where the sum of all edge weights are minimum by picking the edges in Greedy manner.
  In general, the algorithm is designed toward weighted Graph.
  However for non-weighted Graph, it just means the minimum count of edges.

    - [_Kruskal's Minimum Spanning Tree_](https://www.youtube.com/watch?v=fAuF0EuZVCk) (For undirected graph)

    - [_Prim's Minimum Spanning Tree_](https://www.youtube.com/watch?v=oP2-8ysT3QQ) (For directed graph)

      [LeetCode 1584. Min Cost to Connect All Points](https://leetcode.com/problems/min-cost-to-connect-all-points)
