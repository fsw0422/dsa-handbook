# Divide and Conquer

Problems that have _Optimal Substructure_ (problems where solution to the original problem can be constructed from the solutions of its sub-problems) can be solved using Divide and Conquer.
Problems that are solved with Divide and Conquer *do not* have _Overlapping Sub-problems_, which we will discuss later in Dynamic Programming chapter.

Sort / Binary Search are great examples of Divide and Conquer.

# Sort

There are several sorting algorithms with quadratic runtime (_Bubble Sort_, _Insertion Sort_, _Selection Sort_).
However, due to its penalty in time complexity, improved algorithms like below are more likely to be in interviews.

- _Merge Sort_
  ```python
  ...

  def merge_sort(nums: list[int]):
      """
      Stable sorting algorithm (elements with same key preserves ordering) using Divide and Conquer technique.
      The divide step is implemented in simple recursion top-down, while the merge step merge the split 2 lists bottom-up.
  
      Merge sort is NOT an in-place algorithm as it allocates additional space through recursion
  
      TC: O(N*logN)
      SC: O(N)
      """

      def merge(lo: list[int], hi: list[int]):
          """
          We re-use the input list for sorted result, however this is not in-place sort, as we slice list in half and create copy on every recursion
          """
  
          i, j, k = 0, 0, 0

          while i < len(lo) and j < len(hi):
              if lo[i] <= hi[j]:
                  nums[k] = lo[i]
                  i += 1
              else:
                  nums[k] = hi[j]
                  j += 1
              k += 1

          # Drain rest of 'lo'
          while i < len(lo):
              nums[k] = lo[i]
              i += 1
              k += 1

          # Drain rest of 'hi'
          while j < len(hi):
              nums[k] = hi[j]
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

  The more generic version of merge step will be _K Way Merge_ where it merges K Lists.
  - [LeetCode 23. Merge k Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists)
- _Quick Sort_
  ```python
  ...
  
  def quick_sort(nums: list[int]):
      """
      Unstable sorting algorithm (elements with same key does NOT preserve ordering) using Divide and Conquer technique
      Most widely adapted sorting algorithm due to its performance
  
      Quick sort is NOT an in-place algorithm as it allocates additional space through recursion
      Please do not confuse since input list is modified
  
      TC: O(N*logN)
      SC: O(logN)
      """

      def sort(lo: int, hi: int):
  
          def hoare_partition(lo: int, hi: int) -> int:
              i, j = lo - 1, hi + 1
              piv = nums[lo]
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

          def lomuto_partition(lo: int, hi: int) -> int:
              piv = nums[hi]
              i = lo
              for j in range(lo, hi):
                  if nums[j] <= piv:
                      nums[i], nums[j] = nums[j], nums[i]
                      i += 1
              nums[i], nums[hi] = nums[hi], nums[i]
              return i
  
          if lo >= hi:
              return
  
          # pivot_idx = hoare_partition(lo, hi)
          pivot_idx = lomuto_partition(lo, hi)
          sort(lo, pivot_idx - 1)
          sort(pivot_idx + 1, hi)
  
      sort(0, len(nums) - 1)
  ```
- [_Counting Sort_](https://www.youtube.com/watch?v=OKd534EWcdk)
- [_Radix Sort_](https://www.youtube.com/watch?v=XiuSW_mEn7g)

Revisiting 'finding top-K / bottom-K elements' using _Quick Select_ (partitioning part of _Quick Sort_) or _Counting_ (counting part of _Counting Sort_) to achieve near O(N) performance.
- [LeetCode 215. Kth Largest Element in an Array](https://leetcode.com/problems/kth-largest-element-in-an-array)

```python
"""
Basic Operations

Python uses Tim Sort
TC: O(NlogN)
SC: O(N) Average
"""
nums = [3, 1, 6, 5]
nums.sort() # [1, 3, 5, 6] (In-place)
sorted_nums = sorted(nums) # [1, 3, 5, 6] (New list, not an iterator)

sorted_word = sorted('bacd') # ['a', 'b', 'c', 'd']

tuple_list = [(1, 3), (3, 2), (2, 1)]
sorted_by_first = sorted(tuple_list, key=lambda x: x[0]) # [(1, 3), (2, 1), (3, 2)]
sorted_by_second = sorted(tuple_list, key=lambda x: x[1]) # [(2, 1), (3, 2), (1, 3)]
tuple_list.sort() # [(1, 3), (2, 1), (3, 2)]
tuple_list.sort(key=lambda x: x[0]) # [(1, 3), (2, 1), (3, 2)]
tuple_list.sort(key=lambda x: x[1]) # [(2, 1), (3, 2), (1, 3)]
```

# Binary Search

```python
import bisect


"""
Basic Operations

TC: O(logN)
"""
nums = [0, 1, 2, 2, 3, 6]
left = bisect.bisect_left(nums, 2) # TC: O(logN) - 2 (Returns the left-most place in the sorted list to insert the given element)
right = bisect.bisect_right(nums, 2) # TC: O(logN) - 5 (Returns the right-most place in the sorted list to insert the given element)
ranged_left = bisect.bisect_left(nums, 12, lo=1, hi=5) # TC: O(logN) - 5 (Parameters allow range search. Index will return based on the scope of range)
ranged_right = bisect.bisect_right(nums, 12, lo=1, hi=5) # TC: O(logN) - 5 (Parameters allow range search. Index will return based on the scope of range)

if left == right: # It means value is not found
    ...
if left != right: # It means value is found
    # To find the actual index of the first and last occurrence of the 'val', it should be either 'left' or 'right' - 1
    ...
```
- Almost all Binary Search questions involve using either
  - Lists that is given either sorted or unsorted.
    - Not sorted:
      Need to use the built-in sort function and then think about what to apply with the sorted List.
      - [LeetCode 56. Merge Intervals](https://leetcode.com/problems/merge-intervals)
      - [LeetCode 242. Valid Anagram](https://leetcode.com/problems/valid-anagram)
    - Sorted:
      The intention of these questions are to reach the optimal time complexity (O(logN)) with a slightly tweaked sorted structure.
      This means it's to either use the built-in Binary Search method or implement a customized version yourself to meet the use case.

      ```python
      ...
      
      """
      This function is simplified (but customizable) Binary Search function.
      There are problems that require you to tweak this function in order to solve the problem.
      """
      def binary_search(nums: list[int], target) -> int:
          lo = 0
          hi = len(nums) - 1
          while lo <= hi:
              mid = lo + (hi - lo) // 2 # Prevent overflow

              # Target is found (tweak is often required here)
              if nums[mid] == target:
                  return mid

              # Tune 'lo' and 'hi' if pivot is not found
              if nums[mid] <= nums[hi]:
                  hi = mid - 1
              elif nums[mid] >= nums[lo]:
                  lo = mid + 1
          return -1
      ```

      - [LeetCode 33. Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array)
      - [LeetCode 34. Find First and Last Position of Element in Sorted Array](https://leetcode.com/problems/find-first-and-last-position-of-element-in-sorted-array)
    - Root node of a Binary Tree that is sorted when traversed in-order.

# Self-Balancing Binary Search Tree

So far, we've looked into Sort / Binary Search on non-changing data sets since elements need to be only sorted once for Binary Search(es).
However, when elements are dynamically added / deleted, sorting the entire List every time is not efficient.
To address this issue, we use a special data structure called Self-Balancing Binary Search Tree.
Self-Balancing Binary Search Tree is a unique data structure not only because it keeps the ordering of elements, but it also self balances when you add / delete elements.
This is an important feature since without it, the tree will eventually get imbalanced and the search can take up to O(N) in worst case (same as linear scan).
Below is the time complexity of core operations on _Red Black Tree_ (a variant of Self-Balancing Binary Search Tree).
- [Insert](https://www.youtube.com/watch?v=UaLIHuR1t8Q) O(logN)
- [Delete](https://www.youtube.com/watch?v=CTvfzU_uNKE) O(logN)
- Access O(logN)

Python does not have a built-in Red-Black tree.
However, there is a widely used 3rd-party library called [sortedcontainers](https://grantjenks.com/docs/sortedcontainers/) and is generally allowed in interviews.
- [LeetCode 1244. Design A Leaderboard](https://leetcode.com/problems/design-a-leaderboard)
- [LeetCode 729. My Calendar I](https://leetcode.com/problems/my-calendar-i)
- [LeetCode 731. My Calendar II](https://leetcode.com/problems/my-calendar-ii)
