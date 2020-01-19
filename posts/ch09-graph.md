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
                self.vertex_to_parent = {vertex: vertex for vertex in graph.keys()}
                self.vertex_to_rank = {vertex: 0 for vertex in graph.keys()}
                for vertex, neighbours in graph.items():
                    for neighbour in neighbours:
                        self.union(vertex, neighbour)
    
            def union(self, vertex1: Any, vertex2: Any):
                parent1 = self.find(vertex1)
                parent2 = self.find(vertex2)
                if parent1 != parent2:
                    if self.vertex_to_rank[parent1] > self.vertex_to_rank[parent2]:
                        self.vertex_to_parent[parent2] = parent1
                    elif self.vertex_to_rank[parent1] < self.vertex_to_rank[parent2]:
                        self.vertex_to_parent[parent1] = parent2
                    else:
                        self.vertex_to_parent[parent2] = parent1
                        self.vertex_to_rank[parent1] += 1
    
            def find(self, vertex: Any) -> Any:
                parent = self.vertex_to_parent[vertex]
                if parent != vertex:
                    parent = self.find(parent)
                    self.vertex_to_parent[vertex] = parent
                return parent
        ```
    
      Also used for cycle detection in Undirected Graph.
    
      [LeetCode 684. Redundant Connection](https://leetcode.com/problems/redundant-connection)
    
      [LeetCode 685. Redundant Connection II](https://leetcode.com/problems/redundant-connection-ii)

- _Directed Graph_:
  Graph that contains vertices with direction.

    - _Topological Sort_:
      Ordering of the vertices where each edge is from the "vertex earlier in the ordering" to "vertex later in the ordering".
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
            for vertex in graph:
                for _ in graph[vertex]:
                    in_degree += 1

            # Initialize queue with vertices that have in-degree of 0 (starting vertices)
            queue = deque([vertex for vertex in graph if in_degree[vertex] == 0])

            # Remove in-degree one-by-one and add neighbouring vertices only if there is no in-degree (meaning it turned into start vertice) for next process order
            top_sorted = list()
            while queue:
                start = queue.popleft()
                top_sorted.append(start)
                for neighbour in graph[start]:
                    in_degree[neighbour] -= 1
                    if in_degree[neighbour] == 0:
                        queue.append(neighbour)

            # If cycle exist, queue will be empty earlier and terminate before adding everything to 'top-sorted'
            # For example, for graph 'A -> B -> A', initialized queue will be empty as there are no starting vertices in the first place
            if len(graph) > len(top_sorted):
                raise Exception("Cycle detected in graph")

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
                for c in word:
                    if c not in cur.children:
                        cur.children[c] = self._Node()
                    cur = cur.children[c]
                cur.end = True

            def start_with(self, prefix: str) -> bool:
                cur = self._root
                for c in prefix:
                    if c not in cur.children:
                        return False
                    cur = cur.children[c]
                return True

            def longest_prefix(self) -> str:
                prefix = list()
                cur = self._root
                while len(cur.children) == 1:
                    for c in cur.children:
                        if not cur.end:
                            prefix.append(c)
                            cur = cur.children[c]
                        else:
                            return "".join(prefix)
                return "".join(prefix)
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
    graph = {
      "a": {"b", "c", "d"},
      "b": {"e", "f"},
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


    def dfs(graph: Dict[Any, Set[Any]], start_vertex: Any) -> List[Any]:
        """
        TC: O(|V| + |E|)
        SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
        """

        collected = list()
        visited = set()

        def recurse(vertex: Any):
            if vertex not in visited:
                visited.add(vertex)
                collected.append(vertex)
                for neighbour in graph[vertex]:
                    recurse(neighbour)

        def iterate(vertex: Any):
            stack = deque()
            visited.add(start_vertex)
            stack.append(start_vertex)
            while stack:
                cur = stack.pop()
                collected.append(cur)
                for neighbour in graph[cur]:
                    if neighbour not in visited:
                        visited.add(neighbour)
                        stack.append(neighbour)

        recurse(start_vertex)
        #iterate(start_vertex)
        return collected
    ```

    [LeetCode 200. Number of Islands](https://leetcode.com/problems/number-of-islands)

- _Breadth First Search (BFS)_:
  Queue is used for implementation.
  Used for finding the shortest path between 2 vertices.
  In fact, BFS is a generalization of Level-order traversal of Binary Tree in previous chapter (as Graph is also one form of generalization of a N-ary Tree)

    ```python
    ...
  
    from typing import Any, Dict, Set, List
    from collections import deque


    def bfs(graph: Dict[Any, Set[Any]], start_vertex: Any) -> List[Any]:
        """
        TC: O(|V| + |E|)
        SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
        """

        collected = list()
        visited = set()

        queue = deque()
        visited.add(start_vertex)
        queue.append(start_vertex)
        while queue:
            cur = queue.popleft()
            collected.append(cur)
            for neighbour in graph[cur]:
                if neighbour not in visited:
                    visited.add(neighbour)
                    queue.append(neighbour)
        return collected
    ```

    [LeetCode 934. Shortest Bridge](https://leetcode.com/problems/shortest-bridge)

## Backtracking

_Backtracking_ problems require you to search large number of paths in order to reach the solution (often has exponential time complexity).
DFS becomes very handy for these problems.
Make sure you draw the call graph for better understanding for yourself as well as the interviewer.

[LeetCode 78. Subsets](https://leetcode.com/problems/subsets)

[LeetCode 90. Subsets II](https://leetcode.com/problems/subsets-ii)

[LeetCode 46. Permutations](https://leetcode.com/problems/permutations)

[LeetCode 47. Permutations II](https://leetcode.com/problems/permutations-ii)

[LeetCode 77. Combinations](https://leetcode.com/problems/combinations)

[LeetCode 39. Combination Sum](https://leetcode.com/problems/combination-sum)

[LeetCode 40. Combination Sum II](https://leetcode.com/problems/combination-sum-ii)

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
