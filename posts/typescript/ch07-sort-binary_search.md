# Divide and Conquer

Problems that have Optimal Substructure (problems where solution to the original problem can be constructed from the solutions of its subproblems) can be solved using Divide and Conquer.
Problems that are solved with Divide and Conquer do not have Overlapping Subproblems, which we will discuss later in Dynamic Programming chapter.

Sort / Binary Search are great examples of Divide and Conquer.

# Sort

There are several sorting algorithms with quadratic runtime (Bubble Sort, Insertion Sort, Selection Sort).
However, due to their time-complexity penalty, improved algorithms like below are more likely to be in interviews.

- Merge Sort

  ```typescript
  ...

  function mergeSort(nums: number[]): void {
      /**
       * Stable sorting algorithm (elements with same key preserves ordering) using Divide and Conquer technique.
       * The divide step is implemented in simple recursion top-down, while the merge step merge the split 2 arrays bottom-up.
       *
       * TC: O(N*logN)
       * SC: O(N)
       */

      function merge(arr: number[], loNums: number[], hiNums: number[]): void {
          let i = 0, j = 0, k = 0;

          while (i < loNums.length && j < hiNums.length) {
              if (loNums[i] <= hiNums[j]) {
                  arr[k] = loNums[i];
                  i++;
              } else {
                  arr[k] = hiNums[j];
                  j++;
              }
              k++;
          }

          // Drain rest of 'loNums'
          while (i < loNums.length) {
              arr[k] = loNums[i];
              i++;
              k++;
          }

          // Drain rest of 'hiNums'
          while (j < hiNums.length) {
              arr[k] = hiNums[j];
              j++;
              k++;
          }
      }

      if (nums.length <= 1) return;

      const mid = Math.floor(nums.length / 2);
      const left = nums.slice(0, mid);
      const right = nums.slice(mid);

      mergeSort(left);
      mergeSort(right);
      merge(nums, left, right);
  }
  ```

  The more generic version of merge step will be K Way Merge where it merges K Arrays.
  - [LeetCode 23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists)
- Quick Sort

  ```typescript
  ...

  function quickSort(nums: number[]): void {
      /**
       * Unstable sorting algorithm (elements with same key does NOT preserve ordering) using Divide and Conquer technique
       * Most widely adapted sorting algorithm due to its performance
       *
       * TC: O(N*logN)
       * SC: O(logN)
       */

      function sort(lo: number, hi: number): void {

          function hoarePartition(_lo: number, _hi: number): number {
              let i = _lo - 1, j = _hi + 1;
              const piv = nums[_lo];
              while (true) {
                  i++;
                  while (nums[i] < piv) i++;
                  j--;
                  while (nums[j] > piv) j--;
                  if (i >= j) break;
                  [nums[i], nums[j]] = [nums[j], nums[i]];
              }
              return j;
          }

          function lomutoPartition(_lo: number, _hi: number): number {
              const piv = nums[_hi];
              let i = _lo;
              for (let j = _lo; j < _hi; j++) {
                  if (nums[j] <= piv) {
                      [nums[i], nums[j]] = [nums[j], nums[i]];
                      i++;
                  }
              }
              [nums[i], nums[_hi]] = [nums[_hi], nums[i]];
              return i;
          }

          if (lo >= hi) return;

          // const pivIdx = hoarePartition(lo, hi);
          const pivIdx = lomutoPartition(lo, hi);
          sort(lo, pivIdx - 1);
          sort(pivIdx + 1, hi);
      }

      sort(0, nums.length - 1);
  }
  ```
- [Counting Sort](https://www.youtube.com/watch?v=OKd534EWcdk)
- [Radix Sort](https://www.youtube.com/watch?v=XiuSW_mEn7g)

Revisiting 'finding top-K / bottom-K elements' using Quick Select (partitioning part of Quick Sort) or Counting (counting part of Counting Sort) to achieve near O(N) performance.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

```typescript
/**
 * Basic Operations
 *
 * JavaScript uses Tim Sort
 * TC: O(NlogN)
 * SC: O(N) Average
 */
const nums = [3, 1, 6, 5];
nums.sort((a, b) => a - b); // State: [1, 3, 5, 6] => *In-place*. IMPORTANT: always provide comparator for numbers, default sort is lexicographic
[...nums].sort((a, b) => a - b); // Returns: [1, 3, 5, 6] => *New array*

[...'bacd'].sort(); // Returns: ['a', 'b', 'c', 'd']

const num1Num2Tups: [number, number][] = [[1, 3], [3, 2], [2, 1]];
[...num1Num2Tups].sort((a, b) => a[0] - b[0]); // Returns: [[1, 3], [2, 1], [3, 2]]
[...num1Num2Tups].sort((a, b) => a[1] - b[1]); // Returns: [[2, 1], [3, 2], [1, 3]]
num1Num2Tups.sort((a, b) => a[0] - b[0]); // State: [[1, 3], [2, 1], [3, 2]]
num1Num2Tups.sort((a, b) => a[1] - b[1]); // State: [[2, 1], [3, 2], [1, 3]]
```

# Binary Search

TypeScript does not have a built-in `bisect` module like Python. Below is a custom implementation.

```typescript
...

/**
 * bisectLeft / bisectRight equivalents
 *
 * TC: O(logN)
 */
function bisectLeft(nums: number[], target: number, lo = 0, hi = nums.length): number {
    while (lo < hi) {
        const mid = lo + Math.floor((hi - lo) / 2);
        if (nums[mid] < target) lo = mid + 1;
        else hi = mid;
    }
    return lo;
}

function bisectRight(nums: number[], target: number, lo = 0, hi = nums.length): number {
    while (lo < hi) {
        const mid = lo + Math.floor((hi - lo) / 2);
        if (nums[mid] <= target) lo = mid + 1;
        else hi = mid;
    }
    return lo;
}

const nums2 = [0, 1, 2, 2, 3, 6];
const left = bisectLeft(nums2, 2); // Returns: 2 => Left-most place in the sorted array to insert the given element
const right = bisectRight(nums2, 2); // Returns: 4 => Right-most place in the sorted array to insert the given element
if (left === right) { ... } // It means value is not found
if (left !== right) { ... } // It means value is found
    // To find the actual index of the first and last occurrence of the 'val', it should be either 'left' or 'right' - 1

const rangedLeft = bisectLeft(nums2, 12, 1, 5); // Returns: 5 => Parameters allow range search
const rangedRight = bisectRight(nums2, 12, 1, 5); // Returns: 5 => Parameters allow range search
```
- Almost all Binary Search questions involve using either
  - Arrays that are given either sorted or unsorted.
    - Not sorted:
      Need to use the built-in sort function and then think about what to apply with the sorted Array.
      - [LeetCode 56. Merge Intervals](https://leetcode.com/problems/merge-intervals)
      - [LeetCode 242. Valid Anagram](https://leetcode.com/problems/valid-anagram)
    - Sorted:
      The intention of these questions is to reach the optimal time complexity (O(logN)) with a slightly tweaked sorted structure.
      This means either using the built-in Binary Search method or implement a customized version yourself to meet the use case.

      ```typescript
      ...

      /**
       * This function is simplified (but customizable) Binary Search function.
       * There are problems that require you to tweak this function in order to solve the problem.
       */
      function binarySearch(nums: number[], targ: number): number {
          let lo = 0;
          let hi = nums.length - 1;
          while (lo <= hi) {
              const mid = lo + Math.floor((hi - lo) / 2); // Prevent overflow

              // Target is found (tweak is often required here)
              if (nums[mid] === targ) {
                  return mid;
              }

              // Tune 'lo' and 'hi' if pivot is not found
              if (nums[mid] <= nums[hi]) {
                  hi = mid - 1;
              } else if (nums[mid] >= nums[lo]) {
                  lo = mid + 1;
              }
          }
          return -1;
      }
      ```

      - [LeetCode 33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array)
      - [LeetCode 34. Find First and Last Position of Element in Sorted Array](https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array)
    - Root node of a Binary Tree that is sorted when traversed in-order.

# Self-Balancing Binary Search Tree

So far, we've looked into Sort / Binary Search on non-changing datasets since elements need to be sorted only once for Binary Search(es).
However, when elements are dynamically added / deleted, sorting the entire Array every time is not efficient.
To address this issue, we use a special data structure called Self-Balancing Binary Search Tree.
Self-Balancing Binary Search Tree is a unique data structure not only because it keeps the ordering of elements, but it also self-balances when you add / delete elements.
This is an important feature since without it, the tree will eventually get imbalanced and the search can take up to O(N) in the worst case (same as linear scan).
Below is the time complexity of core operations on Red Black Tree (a variant of Self-Balancing Binary Search Tree).
- [Insert](https://www.youtube.com/watch?v=UaLIHuR1t8Q) O(logN)
- [Delete](https://www.youtube.com/watch?v=CTvfzU_uNKE) O(logN)
- Access O(logN)

TypeScript / JavaScript does not have a built-in Red-Black tree or sorted container.
For interviews, you would either implement a simplified version or explain the concept.
Third-party libraries like [bintrees](https://www.npmjs.com/package/bintrees) or [sorted-btree](https://www.npmjs.com/package/sorted-btree) can be used if allowed.
- [LeetCode 1244. Design A Leaderboard](https://leetcode.com/problems/design-a-leaderboard)
- [LeetCode 729. My Calendar I](https://leetcode.com/problems/my-calendar-i)
- [LeetCode 731. My Calendar II](https://leetcode.com/problems/my-calendar-ii)
