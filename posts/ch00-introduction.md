# Introduction

## Foundation of Coding Interviews

**Never code first:**

1. Clarify the problem with given examples to make sure you are on the right page with the interviewer.
   If it's a design question (eg. design LRU cache) make sure to clarify interfaces of the class you are implementing along with the trade-offs of possible approaches.
2. Discuss edge (_Base Case_ in _Recursion_) / extreme cases.
   The cases defined here along with the given example cases become the test cases in the following steps.
   Define the input / output of the cases found.
3. When you came up with an algorithm, walk through the steps with drawings by using the test cases you've come up with in previous steps.
   Write down key points in each step with pseudocode if you need to.
4. Discuss time / space complexity.
5. Implement code.
6. Test with example and dry-run with edge / extreme cases.
7. Optimize and reiterate.

**Start drawing things no matter what:**

An average person cannot fit an entire solution process of a complex problem in their brain, since it is hard to keep track of states while coming up with logic for solution (multitasking is not a nature for everyone).
For this reason, start out by drawing anything on whiteboard (even by reciting the question).
This will help your brain to focus on the solution logic.

**Become a debugger yourself when testing:**

When debugging with debugging tools, we have an observer window to observe variables or stack values for each step.
You need to be the debugger yourself to show how the input is processed in each step.

**Think of a suboptimal solution first:**

1. Always come up with a suboptimal (can be even brute force) solution first, since it has the advantage of
   - You're guaranteed minimum points, as it can be a checkpoint (better than not being able to implement an optimal approach on first try).
   - The interviewer can offer hints from this checkpoint if you cannot think of further optimal approach.
   - If the suboptimal approach gets improved, there will be extra points for the improvement process itself rather than jumping to the most optimal solution.
   - Some problems (like Dynamic Programming problems) are mostly half-solved, when you have a working suboptimal solution because the optimal approach is to just revise the code a bit.
2. Explain the steps in pseudocode but do not implement it yet.
   If the suboptimal approach is either too simple or complex to code, ask the interviewer if we can jump to better solution.
   This is better than not communicating the suboptimal approach at all and later mess up with the optimal approach.
3. If you don't have much time left, but you know an optimisation technique, quickly just mentioning the approach along with time / space complexity can get you some extra points.

**Stick to a coding style:**

- Coding style seems trivial, but it may give the interviewer the impression of how much you care about code quality.
- Google has great [coding standards](https://google.github.io/styleguide) you can use as a base.

**Smartly name parameter, variables and methods:**

- This also gives the interviewer the impression of how much you care about code quality.

**Know your language libraries:**

- You need to be master of the language you've chosen for the interview.
  You will not be able to look up the internet for core APIs, therefore be sure to learn them by heart.
- Showing good knowledge of the language of your choice conveys good impression to the interviewer.

**Make use of non-implemented methods with robust interface when sketching higher level implementation:**

- This can greatly help you focus on sketching the higher level code.
  You can tell your interviewer you will implement the empty methods later.
- You can demonstrate simple TDD lifecycle since empty methods will fail the test, and you can make it pass by implementing it.
- The interviewer may give you extra points for testability, modularization and readability of code.

**Think of the interviewer as your colleague:**

- Consider the interview as a laid back discussion in a meeting.
- Don’t choke and always communicate with interviewer **out loud** even if you don't know where you're going.

## How to Use LeetCode

- Difficulties (easy, medium, hard) can be an overall indicator, yet do not get too much attached to it since difficulty is subjective.
  Easy labeled problems can turn into medium if further optimisation is required, or mediums can turn easy if the problem is well-known.
  Interviewer's expectation will also vary based on the these elements.
- Learn various ways to solve a particular problem.
  Only aiming for the most optimal solution will prevent you from learning many other creative ways to solve a problem.
  Learning various ways to solve a particular problem will definitely strengthen your fundamentals and later help you approach problems you have never seen before.
  For example, if you are introduced with a solution of a Dynamic Programming problem with Tabulation, try to solve it with Memoization.
  Remember, **Quality over Quantity**.
- There are questions that are a tweak of another problem and look something like 'Some Problem I' and 'Some Problem II'.
  Solve the original version 'Some Problem I' and others in ordering of number, as this will give you the feeling of solving a problem and it's follow-ups.
- Do not hold on to one problem for more than 1 hour.
  If the bar is too high, break open a hint or go to solutions.
  - Not looking at the solution is a good practice but there is also limited time for preparation.
    Also, some problems simply require specific knowledge to nail it, therefore as a rule of thumb
    - Look at the solution although never skip implementing the solution yourself.
      Oftentimes there are specific knowledge or tricks that you will learn from a problem.
    - Understand every aspect of the solution (Why was recursion used here? /Why is parameter passed this way? etc.).
    - Come back to the problem 1 week later and solve from scratch.
      If you can, you have completely understood the solution.
  - Exceptionally hard problems (acceptance rate lower than 20%) are mostly not expected to be solved optimally within time, so try to focus on pattern recognition and a working solution.
  - When you're really short of time, follow the foundation above but leave out the coding part.
    Compare your solutions with the LeetCode solutions, take notes and move on.
- Code on _Google Docs_ or _Coder Pad_ since it does not rely on LeetCode's helper functionalities.
  Coding on these plain text editors will be the more close to the actual interviewing environment and help you develop the habit of
  - Defining the method signature yourself (you can't rely on ready-made method signature like in LeetCode in interviews).
  - Coming up with generic and edge / extreme case inputs yourself (you can't rely on ready-made test cases like in LeetCode in interviews).
  - Testing your application line-by-line with the input you came up with (You can't compile / run / debug your code like in LeetCode in interviews).
    Especially in LeetCode, there is a 'run' button which is very easy to abuse leading to premature commitment of your code. This is a huge **Red Flag**.
    Only once you're done coding in the plain text editor, copy-paste and run the code on LeetCode to confirm any missed test cases.
- Finally, [NeetCode 150](leetcode.com/problem-list/adc2unt1) covers almost all patterns of questions.
  Digest every pattern and approaches in this list and implement it yourself.
  If you can comfortably solve at least medium questions in 20 minutes, you are ready-for-interview.
