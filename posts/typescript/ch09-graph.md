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

    ```typescript
    ...

    class DisjointSet<T> {
        private vtxToPar: Map<T, T>;
        private vtxToRnk: Map<T, number>;

        constructor(gph: Map<T, Set<T>>) {
            this.vtxToPar = new Map<T, T>();
            this.vtxToRnk = new Map<T, number>();
            for (const vtx of gph.keys()) {
                this.vtxToPar.set(vtx, vtx);
                this.vtxToRnk.set(vtx, 0);
            }
            for (const [vtx, nbrs] of gph.entries()) {
                for (const nbr of nbrs) {
                    this.union(vtx, nbr);
                }
            }
        }

        union(vtx1: T, vtx2: T): void {
            const par1 = this.find(vtx1);
            const par2 = this.find(vtx2);
            if (par1 !== par2) {
                const rnk1 = this.vtxToRnk.get(par1)!;
                const rnk2 = this.vtxToRnk.get(par2)!;
                if (rnk1 > rnk2) {
                    this.vtxToPar.set(par2, par1);
                } else if (rnk1 < rnk2) {
                    this.vtxToPar.set(par1, par2);
                } else {
                    this.vtxToPar.set(par2, par1);
                    this.vtxToRnk.set(par1, rnk1 + 1);
                }
            }
        }

        find(vtx: T): T {
            let par = this.vtxToPar.get(vtx)!;
            if (par !== vtx) {
                par = this.find(par);
                this.vtxToPar.set(vtx, par);
            }
            return par;
        }
    }
    ```

    Also used for cycle detection in Undirected Graph.
    - [LeetCode 684. Redundant Connection](https://leetcode.com/problems/redundant-connection)
    - [LeetCode 685. Redundant Connection II](https://leetcode.com/problems/redundant-connection-ii)
- Directed Graph:
  Graph that contains vertices with direction.
  - Topological Sort:
    Ordering of the vertices where each edge is from the vertex earlier in the ordering to vertex later in the ordering.
    It represents the dependency graph of vertices (thus can detect cycles in Directed Graphs).

    ![topologicalordering](/images/graph/topological_ordering.png)

    ```typescript
    ...

    import { Queue } from '@datastructures-js/queue';

    function topSort<T>(gph: Map<T, Set<T>>): T[] {
        /**
         * Using Khan's Algorithm
         */

        // Build-up all in-degree (edge that connects toward the vertex) counts of each vertex
        const inDeg = new Map<T, number>();
        for (const vtx of gph.keys()) {
            if (!inDeg.has(vtx)) inDeg.set(vtx, 0);
            for (const nbr of gph.get(vtx)!) {
                inDeg.set(nbr, (inDeg.get(nbr) ?? 0) + 1);
            }
        }

        // Initialize queue with vertices that have in-degree of 0 (starting vertices)
        const que = new Queue<T>();
        for (const [vtx, deg] of inDeg.entries()) {
            if (deg === 0) que.enqueue(vtx);
        }

        // Remove in-degree one by one and add neighboring vertices only if there is no in-degree (meaning it turned into a start vertex) for the next process order
        const topSorted: T[] = [];
        while (!que.isEmpty()) {
            const start = que.dequeue()!;
            topSorted.push(start);
            for (const nbr of (gph.get(start) ?? new Set())) {
                const newDeg = inDeg.get(nbr)! - 1;
                inDeg.set(nbr, newDeg);
                if (newDeg === 0) {
                    que.enqueue(nbr);
                }
            }
        }

        // If a cycle exists, the queue will be empty earlier and terminate before adding everything to 'topSorted'
        // For example, for graph 'A -> B -> A', initialized queue will be empty as there are no starting vertices in the first place
        if (gph.size > topSorted.length) {
            throw new Error('Cycle detected in graph');
        }

        return topSorted;
    }
    ```

    - [LeetCode 207. Course Schedule](https://leetcode.com/problems/course-schedule)
    - [LeetCode 269. Alien Dictionary](https://leetcode.com/problems/alien-dictionary)
  - Trie:
    Tree that is optimized for matching prefix of words.
    We will be using [@datastructures-js/trie](https://datastructures-js.info/docs/trie) which provides a performant, type-safe implementation.

    ![trie](/images/graph/trie.png)

    ```typescript
    ...

    import { Trie } from '@datastructures-js/trie';

    const trie = new Trie();
    trie.insert('hello');
    trie.insert('help');
    trie.insert('world');

    trie.has('hello'); // true
    trie.has('hel'); // false (not a complete word)
    trie.find('hello'); // TrieNode of last character 'o' (null if not found)
    trie.remove('hello'); // 'hello' (returns null if not found)
    trie.wordsCount(); // Number of words in the trie
    trie.toArray(); // Array of all words

    // Build a trie from an existing array
    const trie2 = Trie.fromArray(['cat', 'car', 'card']);
    ```

    - [LeetCode 208. Implement Trie](https://leetcode.com/problems/implement-trie-prefix-tree)
    - [LeetCode 14. Longest Common Prefix](https://leetcode.com/problems/longest-common-prefix)

## Representation

- Adjacency Matrix:
  Represents the Graph in N x N matrix.

  ![adjmatrix](/images/graph/adj_matrix.png)

  - [LeetCode 1615. Maximal Network Rank](https://leetcode.com/problems/maximal-network-rank)
- Adjacency Set:
  Represents mapping of vertex -> set of neighboring vertices.

  ```typescript
  ...

  const gph = new Map<string, Set<string>>([
      ['a', new Set(['b', 'c', 'd'])],
      ['b', new Set(['e', 'f'])],
  ]);
  ```

Sometimes, only edges are given so we need to build the graph from scratch.
You can build the graph in either way.

## Search

- Depth First Search (DFS):
  Recursion is used for implementation.
  In fact, DFS is a generalization of Pre / Post / In-order traversals of binary tree in the previous chapter (as Graph is also one form of generalization of a N-ary tree)

  ```typescript
  ...

  function dfs<T>(gph: Map<T, Set<T>>, start: T): T[] {
      /**
       * TC: O(|V| + |E|)
       * SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
       */

      const res: T[] = [];
      const seen = new Set<T>();

      function recurse(vtx: T): void {
          if (seen.has(vtx)) return;

          seen.add(vtx);
          res.push(vtx);
          for (const nbr of (gph.get(vtx) ?? new Set())) {
              recurse(nbr);
          }
      }

      function iterate(vtx: T): void {
          const stk: T[] = [];
          seen.add(vtx);
          stk.push(vtx);
          while (stk.length > 0) {
              const cur = stk.pop()!;
              res.push(cur);
              for (const nbr of (gph.get(cur) ?? new Set())) {
                  if (seen.has(nbr)) continue;

                  seen.add(nbr);
                  stk.push(nbr);
              }
          }
      }

      recurse(start);
      //iterate(start);
      return res;
  }
  ```

  - [LeetCode 200. Number of Islands](https://leetcode.com/problems/number-of-islands)
- Breadth First Search (BFS):
  Queue is used for implementation.
    Used to find the shortest path between 2 vertices, minimal steps to reach a target, etc.
    In fact, BFS is a generalization of Level-order traversal of binary tree in the previous chapter (as Graph is also one form of generalization of a N-ary tree)

  ```typescript
  ...

  import { Queue } from '@datastructures-js/queue';

  function bfs<T>(gph: Map<T, Set<T>>, start: T): T[] {
      /**
       * TC: O(|V| + |E|)
       * SC: O(|V|) (Adjacency List) / O(|V| ^ 2) (Adjacency Matrix)
       */

      const res: T[] = [];
      const seen = new Set<T>();

      const que = new Queue<T>();
      seen.add(start);
      que.enqueue(start);
      while (!que.isEmpty()) {
          const cur = que.dequeue()!;
          res.push(cur);
          for (const nbr of (gph.get(cur) ?? new Set())) {
              if (seen.has(nbr)) continue;

              seen.add(nbr);
              que.enqueue(nbr);
          }
      }
      return res;
  }
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
