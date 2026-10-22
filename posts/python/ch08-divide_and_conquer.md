# Divide and Conquer

Divide and conquer splits a problem into smaller subproblems, solves them, and combines their results.
The subproblems are typically solved independently.
When the same subproblem is solved repeatedly, dynamic programming may help reuse its result.

Merge sort and quicksort are common examples.
Binary search uses a related idea: reduce the search space to one smaller subproblem at each step.

## Sort

Bubble sort, insertion sort, and selection sort have quadratic worst-case running time.
The following examples use divide and conquer to achieve O(N * logN) time with balanced splits.

- Merge Sort

  ```python
  ...
  
  from typing import List
  
  
  def merge_sort(nums: List[int]) -> None:
      """
      Sort nums using a stable divide-and-conquer algorithm.
      Elements with equal keys keep their relative order.
      Split the list recursively, then merge the sorted halves as the calls return.
  
      TC: O(N * logN) worst case.
      SC: O(N) auxiliary space for the slices, plus O(logN) call-stack space.
      """
  
      def merge(lo_nums: List[int], hi_nums: List[int]) -> None:
          i = 0
          j = 0
          k = 0

          while i < len(lo_nums) and j < len(hi_nums):
              if lo_nums[i] <= hi_nums[j]:
                  nums[k] = lo_nums[i]
                  i += 1
              else:
                  nums[k] = hi_nums[j]
                  j += 1
              k += 1
  
          # Copy the remaining elements from lo_nums.
          while i < len(lo_nums):
              nums[k] = lo_nums[i]
              i += 1
              k += 1
  
          # Copy the remaining elements from hi_nums.
          while j < len(hi_nums):
              nums[k] = hi_nums[j]
              j += 1
              k += 1
  
      if len(nums) <= 1:
          return
  
      mid = len(nums) // 2
      left = nums[:mid]
      right = nums[mid:]

      merge_sort(left)
      merge_sort(right)
      merge(left, right)
  ```

  A k-way merge generalizes the merge step to combine K sorted lists.

  - [LeetCode 23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists)
- Quick Sort

  ```python
  ...
  
  from enum import Enum, auto
  from typing import List


  class PartitionScheme(Enum):
      LOMUTO = auto()
      HOARE = auto()


  def quick_sort(nums: List[int], partition: PartitionScheme) -> None:
      """
      Sort nums by partitioning around a pivot and recursively sorting each side.
      This algorithm is unstable: elements with equal keys may change relative order.
      Set partition=PartitionScheme.HOARE to use Hoare partitioning.
  
      TC: O(N * logN) average for randomly ordered distinct values, O(N^2) worst case.
      SC: O(logN) average call-stack space, O(N) worst case.
      """

      def sort(lo: int, hi: int) -> None:
  
          def hoare_partition(_lo: int, _hi: int) -> int:
              i = _lo - 1
              j = _hi + 1
              piv = nums[_lo]
              while True:
                  i += 1
                  while nums[i] < piv:
                      i += 1
                  j -= 1
                  while nums[j] > piv:
                      j -= 1
                  if i >= j:
                      break
                  nums[i], nums[j] = nums[j], nums[i]
              return j
  
          def lomuto_partition(_lo: int, _hi: int) -> int:
              piv = nums[_hi]
              i = _lo
              for j in range(_lo, _hi):
                  if nums[j] <= piv:
                      nums[i], nums[j] = nums[j], nums[i]
                      i += 1
              nums[i], nums[_hi] = nums[_hi], nums[i]
              return i
  
          if partition is PartitionScheme.HOARE:
              if lo < hi:
                  split_idx = hoare_partition(lo, hi) # Split boundary, not the pivot's final index.
                  sort(lo, split_idx)
                  sort(split_idx + 1, hi)
          elif partition is PartitionScheme.LOMUTO:
              if lo < hi:
                  piv_idx = lomuto_partition(lo, hi) # Pivot's final index.
                  sort(lo, piv_idx - 1)
                  sort(piv_idx + 1, hi)
          else:
              raise TypeError("partition must be a PartitionScheme")
  
      sort(0, len(nums) - 1)
  ```

  These fixed endpoint pivots can produce unbalanced splits, including on already sorted inputs.
  Deep recursion can exceed Python's recursion-depth limit.

Counting sort and radix sort are alternatives that use properties of the keys.
Counting sort uses a bounded integer key range, while radix sort processes keys digit by digit.

- [Counting Sort](https://www.youtube.com/watch?v=OKd534EWcdk)
- [Radix Sort](https://www.youtube.com/watch?v=XiuSW_mEn7g)

For top-K or bottom-K selection, randomized quickselect uses partitioning to achieve O(N) expected time, with O(N^2) worst-case time.
Sorting the selected K values afterward adds O(K * logK) time.
Counting-based selection takes O(N + R) time and O(R) auxiliary space when integer keys span a range of size R.

- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

```python
"""
Basic Operations

Python's built-in sorts use Timsort and preserve the relative order of equal keys.
TC: O(N * logN) worst case, O(N) best case when existing runs can be used.
SC: O(N) worst-case auxiliary space.
"""
nums = [3, 1, 6, 5]
nums.sort() # Returns: None, State: [1, 3, 5, 6] => Modifies the existing list.
sorted(nums) # Returns: [1, 3, 5, 6] => Creates a new list.

sorted('bacd') # Returns: ['a', 'b', 'c', 'd']

num1_num2_tups = [(1, 3), (3, 2), (2, 1)]
sorted(num1_num2_tups, key=lambda num1_num2: num1_num2[0]) # Returns: [(1, 3), (2, 1), (3, 2)]
sorted(num1_num2_tups, key=lambda num1_num2: num1_num2[1]) # Returns: [(2, 1), (3, 2), (1, 3)]
num1_num2_tups.sort() # State: [(1, 3), (2, 1), (3, 2)]
num1_num2_tups.sort(key=lambda num1_num2: num1_num2[0]) # State: [(1, 3), (2, 1), (3, 2)]
num1_num2_tups.sort(key=lambda num1_num2: num1_num2[1]) # State: [(2, 1), (3, 2), (1, 3)]
```

Sorting can also simplify interval and string problems.

- [LeetCode 56. Merge Intervals](https://leetcode.com/problems/merge-intervals)
- [LeetCode 242. Valid Anagram](https://leetcode.com/problems/valid-anagram)

## Binary Search

Binary search requires an ordered search space.
For a sorted list, compare the target with the middle element and discard the half that cannot contain it.
There is usually no combine step.

The `bisect` functions find insertion points in a sorted list.
The optional `lo` and `hi` bounds restrict the search to `nums[lo:hi]`, with `hi` excluded.
The returned insertion index is measured from the start of the original list and can equal `hi`.

```python
import bisect as bs


"""
Basic Operations

TC: O(logN)
"""
nums = [0, 1, 2, 2, 3, 6]
l = bs.bisect_left(nums, 2) # TC: O(logN) - Returns: 2 => Insert before existing values equal to 2.
r = bs.bisect_right(nums, 2) # TC: O(logN) - Returns: 4 => Insert after existing values equal to 2.
if l == r: # The value is absent.
    ...
if l != r: # The value is present.
    first_idx = l
    last_idx = r - 1

bs.bisect_left(nums, 12, lo=1, hi=5) # TC: O(logN) - Returns: 5 => Insertion point at the end of the searched range.
bs.bisect_right(nums, 12, lo=1, hi=5) # TC: O(logN) - Returns: 5 => Insertion point at the end of the searched range.
```

For a sorted list, a custom binary search can return a target's index or `-1` when it is absent.
The following implementation returns any matching index when duplicates exist.
Set `method=SearchMethod.RECURSIVE` to use the recursive version.

```python
...

from enum import Enum, auto
from typing import List


class SearchMethod(Enum):
    ITERATIVE = auto()
    RECURSIVE = auto()


def binary_search(nums: List[int], trg: int, method: SearchMethod) -> int:
    """
    Search a list sorted in ascending order without modifying it.

    TC: O(logN).
    SC: O(1) for iteration, O(logN) call-stack space for recursion.
    """

    def rec(lo: int, hi: int) -> int:
        if lo > hi:
            return -1

        mid = (lo + hi) // 2 # Python integers have arbitrary precision. With fixed-width integers, use lo + (hi - lo) // 2 to avoid overflow.

        if nums[mid] == trg:
            return mid

        if nums[mid] < trg:
            return rec(mid + 1, hi)
        else:
            return rec(lo, mid - 1)

    def itr() -> int:
        lo = 0
        hi = len(nums) - 1
        while lo <= hi:
            mid = (lo + hi) // 2 # Python integers have arbitrary precision. With fixed-width integers, use lo + (hi - lo) // 2 to avoid overflow.

            if nums[mid] == trg:
                return mid

            if nums[mid] < trg:
                lo = mid + 1
            else:
                hi = mid - 1
        return -1

    if method is SearchMethod.RECURSIVE:
        return rec(0, len(nums) - 1)
    elif method is SearchMethod.ITERATIVE:
        return itr()
    else:
        raise TypeError("method must be a SearchMethod")


binary_search([1, 3, 5], 3, method=SearchMethod.ITERATIVE) # Returns: 1
binary_search([1, 3, 5], 4, method=SearchMethod.RECURSIVE) # Returns: -1
```

Searching rotated arrays or finding the first or last occurrence requires changes to the search conditions or bounds.

- [LeetCode 33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array)
- [LeetCode 34. Find First and Last Position of Element in Sorted Array](https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array)

Binary search also applies to an answer range when a predicate is monotonic, changing from false to true at most once or vice versa.
A binary search tree provides another form of ordered lookup, whose cost depends on the tree's height.

## Self-Balancing Binary Search Tree

A sorted list supports O(logN) search, but insertion and deletion in the middle can require O(N) element shifts.
A self-balancing binary search tree maintains O(logN) height as elements are added or deleted.
An unbalanced binary search tree can reach O(N) height, making a search as slow as a linear scan.
A red-black tree is one variant with the following worst-case operation costs.

- [Insert](https://www.youtube.com/watch?v=UaLIHuR1t8Q) O(logN)
- [Delete](https://www.youtube.com/watch?v=CTvfzU_uNKE) O(logN)
- Search O(logN)

Python's standard library does not provide a general-purpose self-balancing binary search tree.
The third-party [sortedcontainers](https://grantjenks.com/docs/sortedcontainers/) package provides `SortedList`, `SortedDict`, and `SortedSet`.
Its containers use sorted lists, so their complexity guarantees differ from those of a red-black tree.
Whether third-party packages are allowed depends on the interview or platform.

- [LeetCode 1244. Design A Leaderboard](https://leetcode.com/problems/design-a-leaderboard)
- [LeetCode 729. My Calendar I](https://leetcode.com/problems/my-calendar-i)
- [LeetCode 731. My Calendar II](https://leetcode.com/problems/my-calendar-ii)
