## Coding Tips

- Try to make variable names as short as possible (but readable) as it's repetitive to type the whole variable every time, especially if you don't have autocompletion during interviews.

  ```typescript
  ...

  // Clearly readable and concise when shortened
  const result = ... // (X)
  const res = ... // (O)

  const stack = ... // (X)
  const stk = ... // (O)

  const queue = ... // (X)
  const que = ... // (O)

  const graph = ... // (X)
  const gph = ... // (O)

  // When shortened and not readable, just use entire word
  const s // (X)
  const st // (X)
  const stt // (X)
  const start // (O)

  // If it makes sense in context, it's generally ok
  const [s, e] = ... // start / end
  const [l, r] = ... // left / right
  let [lo, hi] = ... // low / high
  ```
- For 'Array', 'string', 'Set', 'Map', unless the context naturally guides you to name your variables / parameters in a certain way, use generic reserved names (under 'Basic Operations' in every chapter).
  It's designed to be concise, and not clash with built-in types or keywords.

  ```typescript
  ...

  /*
  Uses names in function context
  */
  function compareMarkedWords(wrds: string[]): void {
      const seen = ...
  }

  /*
  Uses generic reserved names
  */
  function compareUniqueStrings(txt: string): void {
      const utxts = ...
  }
  ```
- Use *single quote* (') over *double quote* (") as pressing the Shift key every time is repetitive.

  ```typescript
  ...

  "string" // (X)
  'string' // (O)
  ```
- Although not preferred, but if two or more words are unavoidable for readability (like adjectives or 2 variables with same type), use camelCase to concatenate them.

  ```typescript
  ...

  const awesomeNum = 3
  ```
- Avoid built-in type names for single-word variables.
  
  ```typescript
  ...

  const string = '' // (X)
  const txt = '' // (O)

  const number = 0 // (X)
  const num = 0 // (O)
  ```
- Don't use function parameters as mutable working variables; keep parameters as inputs and assign transformed values to new local variables.

  ```typescript
  ...

  function increment(num: number): void {
      num += 1 // (X)
      const nnum = num + 1 // (O)
  }
  ```
- Group related variable assignments in a single line when they belong to the same context (e.g., pointers, bounds, counters).

  ```typescript
  ...

  let [l, r] = [0, 0]
  let [lo, hi] = [0, nums.length - 1]
  let [i, j] = [0, n - 1]
  ```
- Rather than Enums, use constants to save time

  ```typescript
  ...

  /*
  Not recommended as it needs a lot more coding
  */
  enum Interval {
      START = 0,
      END = 1,
  }
  rng[Interval.START]
  rng[Interval.END]

  /*
  Recommended as it's simpler
  */
  const [START, END] = [0, 1]
  rng[START]
  rng[END]
  ```
- When a nested function parameter has the same name as an outer function parameter, prepend '\_'.

  ```typescript
  ...

  function func1(num: number): void {
      function func2(_num: number): void {
          ...
      }
  }
  ```
- Use destructuring swap to remove the need to introduce another variable.
    
  ```typescript
  ...

  [a, b] = [b, a]
  ```
- In interviews, there are rarely cases where you will need to define a custom class (with method overrides) over primitive types for the encapsulation of data group.
  However, just in case you need to, here is an example of a 'Contact' class.

  ```typescript
  ...

  class Contact {
      constructor(
          public name: string,
          public age: number,
      ) {}

      // For use as Map key or Set element, provide a string key
      key(): string {
          return `${this.name}:${this.age}`
      }

      equals(other: Contact): boolean {
          return this.name === other.name && this.age === other.age
      }

      // Used for custom sorting
      compareTo(other: Contact): number {
          if (this.name !== other.name) return this.name < other.name ? -1 : 1
          return this.age - other.age
      }

      toString(): string {
          return `Contact(name=${this.name}, age=${this.age})`
      }
  }
  ```
