# Set

```typescript
...

/**
 * Allocation
 */
new Set<number>(); // Returns: Set {}
new Set([1, 2, 3]); // Returns: Set {1, 2, 3}

/**
 * Basic Operations
 *
 * Reserve generic variable / parameter names with 'u{val}s' (prepending 'u' for uniqueness)
 */
const unums = new Set([1, 5, 3, 2]);
unums.add(1); // TC: O(1) - State: Set {1, 5, 3, 2}
unums.delete(1); // TC: O(1) - State: Set {5, 3, 2} => Returns false if value does not exist, does not throw

new Set([3, 2, 1, 3, 5]); // Returns: Set {3, 2, 1, 5} => Removes duplicate

unums.size; // TC: O(1)
Math.min(...unums); // TC: O(N) => We mostly care about numbers, as element in interviews
Math.max(...unums); // TC: O(N) => We mostly care about numbers, as element in interviews

if (unums.has(1)) { ... } // TC: O(1)
for (const val of unums) { ... }
```

# Map

```typescript
...

/**
 * Allocation
 */
new Map<string, number>(); // Returns: Map {}
new Map<string, number>([['birds', 1], ['mammals', 2], ['reptiles', 1]]);

// defaultdict equivalent - TypeScript does not have a built-in defaultdict, use a helper or check-and-set pattern
function getOrDefault<K, V>(map: Map<K, V>, key: K, defaultVal: V): V {
    if (!map.has(key)) {
        map.set(key, defaultVal);
    }
    return map.get(key)!;
}

/**
 * Basic Operations
 *
 * Reserve generic variable / parameter names with
 * - '{key}To{Val}' for Maps
 */
const nameToAge = new Map<string, number>([['John', 23], ['Amy', 32], ['George', 43]]);
const nameAgeTups: [string, number][] = [...nameToAge.entries()]; // Returns: [['John', 23], ['Amy', 32], ['George', 43]]
new Map(nameAgeTups); // Returns: Map {'John' => 23, 'Amy' => 32, 'George' => 43} => Tuples can be converted to Map easily
nameToAge.get('John'); // TC: O(1) - Returns: 23 => Returns undefined if key does not exist
nameToAge.delete('Amy'); // TC: O(1) - Returns: true, State: Map {'John' => 23, 'George' => 43} => Returns false if key does not exist

// Keys
const keys = nameToAge.keys();
if (nameToAge.has('John')) { ... } // TC: O(1)
for (const key of nameToAge.keys()) { ... }

// Values
const vals = nameToAge.values();
for (const val of nameToAge.values()) { ... }

// Entries
const entries = nameToAge.entries();
for (const [key, val] of nameToAge.entries()) { ... }

/**
 * Map from Object
 *
 * Plain objects can also be used as dictionaries for string keys
 */
const obj: Record<string, number> = { a: 1, b: 2, c: 3 };
Object.keys(obj); // Returns: ['a', 'b', 'c']
Object.values(obj); // Returns: [1, 2, 3]
Object.entries(obj); // Returns: [['a', 1], ['b', 2], ['c', 3]]

/**
 * Map Comprehension equivalent
 */
const reversed = new Map(
    [...new Map<number, string>([[1, 'a'], [2, 'b'], [3, 'c']])].map(([k, v]) => [v, k])
); // Returns: Map {'a' => 1, 'b' => 2, 'c' => 3}

/**
 * Counter equivalent
 *
 * TypeScript does not have a built-in Counter, use a helper function
 */
function counter<T>(items: Iterable<T>): Map<T, number> {
    const counts = new Map<T, number>();
    for (const item of items) {
        counts.set(item, (counts.get(item) ?? 0) + 1);
    }
    return counts;
}

counter(['banana', 'orange', 'apple', 'apple']); // Returns: Map {'banana' => 1, 'orange' => 1, 'apple' => 2}
counter('hello'); // Returns: Map {'h' => 1, 'e' => 1, 'l' => 2, 'o' => 1}
```

Make sure you understand how Set / Map works internally.
- [LeetCode 705. Design HashSet](https://leetcode.com/problems/design-hashset)
- [LeetCode 706. Design HashMap](https://leetcode.com/problems/design-hashmap)

Set / Map often comes as supporting data structure of a main data structure for optimization purpose (mostly for Array / String in interviews).
- [LeetCode 1. Two Sum](https://leetcode.com/problems/two-sum)
- [LeetCode 125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome)

Set / Map is also used to represent Graphs (covered later) and mark visited nodes.
