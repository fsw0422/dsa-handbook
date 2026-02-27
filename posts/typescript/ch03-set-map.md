# Set

```typescript
...

/*
Allocation
*/
new Set<number>() // Returns: Set {}
new Set([1, 2, 3]) // Returns: Set {1, 2, 3}

/*
Basic Operations

Reserve generic variable / parameter names with 'u{val}s' (prepending 'u' for uniqueness)
*/
const unums = new Set([1, 5, 3, 2])
unums.add(1) // TC: O(1) - State: Set {1, 5, 3, 2}
unums.delete(1) // TC: O(1) - State: Set {5, 3, 2} => Returns 'false' if value does not exist (does not throw)

new Set([3, 2, 1, 3, 5]) // Returns: Set {3, 2, 1, 5} => Removes duplicate

unums.size // TC: O(1)
Math.min(...unums) // TC: O(N) => We mostly care about numbers, as element in interviews
Math.max(...unums) // TC: O(N) => We mostly care about numbers, as element in interviews

if (unums.has(1)) { /* TC: O(1) */ }
for (const unum of unums) { ... }
```

# Map

```typescript
...

/*
Allocation
*/
new Map<string, number>() // Returns: Map {}
new Map<string, number>([['birds', 1], ['mammals', 2], ['reptiles', 1]]) // Returns: Map {'birds' => 1, 'mammals' => 2, 'reptiles' => 1}
// TypeScript does not have a built-in 'defaultdict', but you can use a helper pattern:
// map.get(key) ?? defaultValue

/*
Basic Operations

Reserve generic variable / parameter names with
- '{key}To{Val}' for 'Map's (camelCase)
- '[{key}, {val}]' for tuple arrays
*/
const nameToAge = new Map<string, number>([['John', 23], ['Amy', 32], ['George', 43]])
nameToAge.get('John') // TC: O(1) - Returns: 23 (or 'undefined' if key does not exist)
nameToAge.delete('Amy') // TC: O(1) - Returns: true, State: Map {'John' => 23, 'George' => 43} => Returns 'false' if key does not exist

const unames = [...nameToAge.keys()] // Returns: ['John', 'George']
const nameAgeTups = [...nameToAge.entries()] // Returns: [['John', 23], ['George', 43]]
new Map(nameAgeTups) // Returns: Map {'John' => 23, 'George' => 43} => Tuple arrays can be converted to Map easily

if (nameToAge.has('John')) { /* TC: O(1) */ }
for (const [name, age] of nameToAge) { ... }

// Iterating keys
for (const name of nameToAge.keys()) { ... }

// Iterating values
for (const age of nameToAge.values()) { ... }

// Iterating entries
for (const [name, age] of nameToAge.entries()) { ... }

/*
Object as lightweight Map alternative

Plain objects can be used as a lightweight Map when keys are strings
*/
const nameToAge2: Record<string, number> = { John: 23, Amy: 32, George: 43 }
nameToAge2['John'] // Returns: 23
Object.keys(nameToAge2) // Returns: ['John', 'Amy', 'George']
Object.values(nameToAge2) // Returns: [23, 32, 43]
Object.entries(nameToAge2) // Returns: [['John', 23], ['Amy', 32], ['George', 43]]

/*
Map Comprehension equivalent
*/
// Swap keys and values
new Map([...nameToAge].map(([k, v]) => [v, k])) // Returns: Map {23 => 'John', 43 => 'George'}

/*
Counters

TypeScript does not have a built-in Counter. Use a Map or Record to count items
*/
function counter<T>(items: T[]): Map<T, number> {
    const counts = new Map<T, number>()
    for (const item of items) {
        counts.set(item, (counts.get(item) ?? 0) + 1)
    }
    return counts
}

counter(['banana', 'orange', 'apple', 'apple']) // Returns: Map {'banana' => 1, 'orange' => 1, 'apple' => 2}
counter([...'hello']) // Returns: Map {'h' => 1, 'e' => 1, 'l' => 2, 'o' => 1}
```

Make sure you understand how Set / Map works internally.
- [LeetCode 705. Design HashSet](https://leetcode.com/problems/design-hashset)
- [LeetCode 706. Design HashMap](https://leetcode.com/problems/design-hashmap)

Set / Map often comes as supporting data structure of a main data structure for optimization purpose (mostly for Array / String in interviews).
- [LeetCode 1. Two Sum](https://leetcode.com/problems/two-sum)
- [LeetCode 125. Valid Palindrome](https://leetcode.com/problems/valid-palindrome)

Set / Map is also used to represent Graphs (covered later) and mark visited nodes.
