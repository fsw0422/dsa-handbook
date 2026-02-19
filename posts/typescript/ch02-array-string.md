# Array

```typescript
...

/**
 * Allocation
 */
[]; // Returns: []
[1, 2, 3];
[
    [1, 2],
    [3, 4],
    [5, 6],
];

/**
 * Basic Operations
 *
 * Reserve generic variable / parameter names with '{val}s' or '{val}es' appended (plural)
 * Apply this even if it's grammatically incorrect i.e.) children (x) -> childs (O)
 */
const nums: number[] = [1, 6, 9, 7];
nums.push(3); // TC: Amortized O(1) - State: [1, 6, 9, 7, 3]
nums.splice(2, 0, 1); // TC: O(N) - State: [1, 6, 1, 9, 7, 3] => Inserts 1 at index 2
nums.splice(nums.indexOf(1), 1); // TC: O(N) - State: [6, 1, 9, 7, 3] => Removes first occurrence of 1. indexOf returns -1 if not found
nums[2]; // TC: O(1) - Returns: 9
nums[nums.length - 1]; // TC: O(1) - Returns: 3 => equivalent to Python's nums[-1]
nums.at(-1); // TC: O(1) - Returns: 3 => alternative using `.at()` which supports negative indexing

nums.length; // TC: O(1) - Returns: 5
Math.min(...nums); // TC: O(N) - Returns: 1 => We mostly care about numbers, as elements in interviews
Math.max(...nums); // TC: O(N) - Returns: 9 => We mostly care about numbers, as elements in interviews

if (nums.includes(1)) { ... } // TC: O(N)
for (const e of nums) { ... }

/**
 * Range
 *
 * TypeScript does not have a built-in 'range' like Python
 * Use Array.from or utility function
 */
Array.from({ length: 5 }, (_, i) => i); // Returns: [0, 1, 2, 3, 4]
Array.from({ length: 3 }, (_, i) => i + 2); // Returns: [2, 3, 4]
Array.from({ length: 2 }, (_, i) => 2 + i * 2); // Returns: [2, 4]

/**
 * Copy
 */
const copied = [...nums]; // *Shallow copy*
const copied2 = nums.slice(); // *Shallow copy*

/**
 * Reverse
 */
const nums2 = [1, 2, 3];
[...nums2].reverse(); // TC: O(N) - Returns: [3, 2, 1] => *New array*
nums2.reverse(); // TC: O(N) - State: [3, 2, 1] => *In-place*

/**
 * Slicing
 */
const nums3 = [0, 1, 2, 3, 4, 5, 6, 7];
nums3.slice(2, 2); // Returns: []
nums3.slice(2, 4); // Returns: [2, 3]
nums3.slice(-3, -1); // Returns: [5, 6]
nums3.filter((_, i) => i >= 1 && i < 5 && (i - 1) % 2 === 0); // Returns: [1, 3] => Skip by 2 inclusive from index 1
nums3.slice(2).concat(nums3.slice(0, 2)); // Returns: [2, 3, 4, 5, 6, 7, 0, 1] => Rotates array by '2' to the left

/**
 * Array Creation and Tricks
 */
new Array(2).fill(0); // Returns: [0, 0]
Array.from({ length: 2 }, () => new Array(2).fill(0)); // Returns: [[0, 0], [0, 0]] => **DO NOT USE** new Array(2).fill(new Array(2).fill(0)) since all rows share same reference. This means single row modification will affect all rows
[0, 1, 2].filter(x => x % 2 === 0); // Returns: [0, 2]
[[1, 2], [3, 4]].flat(); // Returns: [1, 2, 3, 4]

/**
 * Others
 */
// zip equivalent (combine two arrays into tuples)
const zipped = [1, 2, 3].map((v, i) => [v, ['zebra', 'tiger', 'giraffe'][i]] as const);
// [1, 'zebra'], [2, 'tiger'], [3, 'giraffe']

// enumerate equivalent
[1, 2, 3].forEach((val, idx) => { ... }); // Returns: (0, 1), (1, 2), (2, 3) => Useful when you need to map value -> index
// or
for (const [idx, val] of [1, 2, 3].entries()) { ... }
```

# String

```typescript
...

/**
 * Allocation
 */
''; // Returns: ''
'hello';
'a'.repeat(5); // Returns: 'aaaaa'

/**
 * Basic Operations
 *
 * Reserve generic variable / parameter names with 'txt'
 */
const txt: string = 'hello';
if (txt.includes('abc')) { ... } // TC: O(N)
for (const ch of txt) { ... }

/**
 * Editing
 *
 * 'string's are immutable, therefore it needs to be converted to array for efficient editing (and if needed converted back to string)
 * Note that operations like 'text1' + 'text2' is an expensive operation as it copies both strings to a new string
 */
const chs: string[] = [...'hello']; // Returns: ['h', 'e', 'l', 'l', 'o']
chs.join(''); // Returns: 'hello'

/**
 * Slicing
 */
// All slicing operations in array are possible in string as well using `.slice()`

/**
 * Prefix / Suffix match
 */
const txt2: string = 'PrefixWordSuffix';
txt2.startsWith('Prefix'); // TC: O(P) - Returns: true
txt2.endsWith('Suffix'); // TC: O(S) - Returns: true

/**
 * Stringify
 */
String(1); // Returns: '1'
String(0.2); // Returns: '0.2'
[1, 2, 3].join(''); // Returns: '123'

/**
 * Numberify
 */
parseInt('23'); // Returns: 23 => number
parseFloat('3.14'); // Returns: 3.14 => number
Number('23'); // Returns: 23

/**
 * Others
 */
'a'.charCodeAt(0); // Returns: 97 => Converts character into unique integer. This is mostly useful when you want to further optimize time/space complexity from using Maps (for example character counts), if you know that you are only dealing with English characters

/**
 * Utility Operations for input sanitization or debug output
 */
'   hello '.trim(); // Returns: 'hello'
'AbCde'.toLowerCase(); // Returns: 'abcde'

const txts: string[] = 'hello,how,are,you'.split(','); // Returns: ['hello', 'how', 'are', 'you']
txts.join(','); // Returns: 'hello,how,are,you'

const name: string = 'Eminem';
const rank: number = 3;
`Name: ${name}, Rank: ${rank}`; // Returns: 'Name: Eminem, Rank: 3'
```
