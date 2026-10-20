# Introduction

## Foundation of Coding Interviews

**Never code first:**

1. Clarify the problem using the given examples to make sure you and the interviewer are on the same page.
   If it's a design question (e.g., designing an LRU cache), clarify the interfaces of the class you are implementing and the trade-offs of possible approaches.
2. Discuss edge cases and extreme inputs.
   These cases, together with the given examples, become your test cases in the following steps.
   Define the input and expected output for each case.
3. Once you've come up with an algorithm, walk through its steps using drawings and the test cases from the previous steps.
   Use pseudocode to capture the key points of each step if needed.
4. Discuss time and space complexity.
5. Implement the code.
6. Test with the given examples and dry-run the edge cases and extreme inputs.
7. Optimize and repeat.

**Start drawing things no matter what:**

Most people cannot keep the entire solution to a complex problem in mind while tracking state and developing the logic (multitasking does not come naturally to everyone).
For this reason, start by drawing something on the whiteboard, even if you're just illustrating the question as you repeat it aloud.
This will help you focus on the solution logic.

**Become a debugger yourself when testing:**

When using a debugger, you can inspect variables and call-stack values at each step.
Act as the debugger yourself to show how the input is processed at each step.

**Think of a suboptimal solution first:**

1. Always come up with a suboptimal solution first, even if it's brute force, for the following reasons:
   - You're guaranteed a minimum score, and the solution provides a checkpoint. This is better than failing to implement an optimal approach on your first try.
   - The interviewer can offer hints from this checkpoint if you cannot think of a better approach.
   - Improving the suboptimal approach earns extra points for the improvement process itself, compared with jumping straight to the optimal solution.
   - Some problems, such as dynamic programming problems, are already half-solved once you have a working suboptimal solution, because reaching the optimal approach only requires a small revision to the code.
2. Explain the steps in pseudocode, but do not implement the solution yet.
   If the suboptimal approach is either too simple or too complex to code, ask the interviewer whether you can move on to a better solution.
   This is better than skipping the explanation of the suboptimal approach and later struggling with the optimal one.
3. If you don't have much time left but know an optimization technique, briefly mentioning the approach and its time and space complexity can earn you some extra points.

**Stick to a coding style:**

- Coding style may seem trivial, but it gives the interviewer a sense of how much you care about code quality.
- Google has great [coding standards](https://google.github.io/styleguide) you can use as a starting point.

**Choose clear names for parameters, variables, and methods:**

- Clear naming also shows the interviewer how much you care about code quality.

**Know your language's libraries:**

- You need to master the language you've chosen for the interview.
  You will not be able to look up core APIs online, so be sure to learn them by heart.
- Demonstrating a strong knowledge of your chosen language makes a good impression on the interviewer.

**Use method stubs with well-defined interfaces when sketching a higher-level implementation:**

- This can help you focus on sketching the higher-level code.
  Tell the interviewer that you will implement the empty methods later.
- You can demonstrate a simple test-driven development (TDD) cycle: tests fail while the methods are empty and pass once you implement them.
- The interviewer may give you extra points for testability, modularization, and code readability.

**Think of the interviewer as your colleague:**

- Think of the interview as a relaxed discussion with a colleague.
- Stay calm and keep explaining your thoughts to the interviewer, even when you're unsure how to proceed.

## How to Use LeetCode

- Difficulty labels (easy, medium, hard) can serve as a general guide, but don't get too attached to them, since difficulty is subjective.
  An easy problem can become a medium one if further optimization is required, while a medium problem can feel easy if you're familiar with it.
  The interviewer's expectations will also vary based on these factors.
- Learn various ways to solve a particular problem.
  Aiming only for the optimal solution prevents you from learning other creative approaches.
  Learning multiple approaches strengthens your fundamentals and helps you tackle problems you have never seen before.
  For example, if you learn a tabulation solution to a dynamic programming problem, try solving it with memoization as well.
  Prioritize quality over quantity.
- Some questions are variations of another problem and have names such as 'Some Problem I' and 'Some Problem II'.
  Solve the original version first, then the others in numerical order, to practice solving a problem and its follow-ups.
- Do not spend more than one hour on a single problem.
  If the problem is too difficult, use a hint or look at the solutions.
  - Avoiding the solution is good practice, but preparation time is limited.
    Some problems also require specific knowledge, so follow these rules of thumb:
    - Look at the solution, but never skip implementing it yourself.
      Often, a problem will teach you specific concepts or tricks.
    - Understand every aspect of the solution: Why was recursion used here? Why is this parameter passed this way?
    - Return to the problem one week later and solve it from scratch.
      If you can, you have fully understood the solution.
  - Exceptionally hard problems (with an acceptance rate below 20%) are generally not expected to be solved optimally within the allotted time, so focus on pattern recognition and a working solution.
  - When you're very short on time, follow the foundational steps above but skip the implementation.
    Compare your approaches with the LeetCode solutions, take notes, and move on.
- Code in Google Docs or CoderPad to avoid relying on LeetCode's helper features.
  Practicing in these editors more closely resembles the interview environment and helps you develop the following habits:
  - Defining method signatures yourself, since you can't rely on ready-made signatures as you can on LeetCode.
  - Coming up with typical inputs, edge cases, and extreme inputs yourself, since you can't rely on ready-made test cases as you can on LeetCode.
  - Testing your code line by line using the inputs you've chosen, since you can't compile, run, or debug your code in interviews as you can on LeetCode.
    LeetCode's 'Run' button is particularly easy to overuse, leading you to commit to an approach prematurely. This is a huge red flag.
    Only after you've finished coding in the editor should you copy and run the code on LeetCode to identify any test cases you've missed.
- Finally, [NeetCode 150](leetcode.com/problem-list/adc2unt1) covers almost all patterns of questions.
  Understand every pattern and approach in this list, and implement each solution yourself.
  If you can comfortably solve problems of at least medium difficulty in 20 minutes, you are ready for an interview.
