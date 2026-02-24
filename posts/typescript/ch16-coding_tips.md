## Coding Tips

- Try to make variable names as short as possible (but readable) as it's repetitive to type the whole variable every time in use, especially if you don't have autocompletion during interviews.
  ```typescript
  ...

  const result: any[] = []; // (X)
  const res: any[] = []; // (O)

  const stack = ...; // (X)
  const stk = ...; // (O)

  const queue = ...; // (X)
  const que = ...; // (O)

  const graph = ...; // (X)
  const gph = ...; // (O)
  ```
- For `Array`, `string`, `Set`, `Map`, unless the context naturally guides you to name your variables / parameters in a certain way, use generic reserved names (under 'Basic Operations' in every chapter).
  It's designed to be concise, and not clash with built-in functions or keywords.
  ```typescript
  ...

  /**
   * Uses names in function context
   */
  function compareMarkedWords(wrds: string[]): void {
      const seen = ...;
  }

  /**
   * Uses generic reserved names
   */
  function compareUniqueStrings(txt: string): void {
      const utxts = ...;
  }
  ```
- Always use *single quote* (') over *double quote* (") as pressing the Shift key every time is repetitive.
  ```typescript
  ...

  "string"; // (X)
  'string'; // (O)
  ```
- If two or more words are unavoidable (like adjectives or 2 variables with same type), use camelCase to concatenate them.
  ```typescript
  ...

  const awesomeNum: number = 3;
  ```
- Avoid keywords for single-word variables.
  
  ```typescript
  ...

  const string: string = ''; // (X)
  const txt: string = ''; // (O)

  const number: number = 0; // (X)
  const num: number = 0; // (O)
  ```
- Rather than Enums, use constants to save time
  ```typescript
  ...

  const interval = Array.from({ length: 10 }, (_, i) => i);

  /**
   * Not recommended as it needs a lot more coding
   */
  enum Interval {
      START = 0,
      END = 1,
  }
  interval[Interval.START];
  interval[Interval.END];

  /**
   * Recommended as it's simpler
   */
  const START = 0;
  const END = 1;
  interval[START];
  interval[END];
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
- Use destructuring swap, as it removes the need to introduce another variable.
    
  ```typescript
  ...

  [a, b] = [b, a];
  ```
- In interviews, there are rarely cases where you will need to define a custom class (with method overrides) over primitive types for the encapsulation of data group.
  However, just in case you need to, here is an example of a 'Contact' class.

  ```typescript
  ...

  class Contact {
      name: string;
      age: number;

      constructor(name: string, age: number) {
          this.name = name;
          this.age = age;
      }

      // Used for equality checks (no built-in eq like Python, must implement manually)
      equals(other: Contact): boolean {
          return this.name === other.name && this.age === other.age;
      }

      // Used for sorting with Array.sort()
      compareTo(other: Contact): number {
          if (this.name !== other.name) return this.name < other.name ? -1 : 1;
          return this.age - other.age;
      }

      toString(): string {
          return `Contact(name=${this.name}, age=${this.age})`;
      }
  }

  // Sorting contacts
  const contacts: Contact[] = [...];
  contacts.sort((a, b) => a.compareTo(b));
  ```
- Use `const` by default, only use `let` when reassignment is needed. Never use `var`.
  ```typescript
  ...

  var num = 3; // (X)
  let num = 3; // (O) when reassignment needed
  const num = 3; // (O) when no reassignment needed
  ```
- Use strict equality (`===` and `!==`) instead of loose equality (`==` and `!=`).
  ```typescript
  ...

  if (a == b) { ... } // (X)
  if (a === b) { ... } // (O)
  ```
