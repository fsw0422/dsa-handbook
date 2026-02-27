# Concurrency

Concurrent programming offers a seamless experience as if multiple programs are running at the same time (even with a single-core CPU).
However, the most interesting part in this subject is blocking operations, along with the problems that follow in order to prevent it.

When processes or threads enter a blocked state, the operating system scheduler reschedules them to run other processes or threads.
Yet, rescheduling of processes or threads is expensive due to context changes, and too many blocked threads (which often happens in I/O-heavy operations) can quickly fill up the task queue, which can lead to OOM.
To resolve this, there were many asynchronous paradigms that emerged in the past decade (with its own problems). To name a few:

- Callbacks:
  When a thread blocks, it is returned to the thread pool and reassigned on callback functions. This however led to problems like callback hell.
- Reactive (Rx):
  Using the Observer Pattern, Reactive paradigms do not suffer from callbacks, however have their own problems of composing streams and the huge learning curve behind it.
- Promises / async-await:
  JavaScript/TypeScript uses an event-loop-based single-threaded concurrency model.
  Promises and async/await provide a clean way to handle asynchronous operations without blocking the event loop.
  Since there is only one thread, there are no traditional race conditions on shared memory.
  However, logical race conditions can still occur with interleaved async operations.

  ```typescript
  ...

  /*
  We will be focusing on Promises / async-await, as it's the de-facto way of asynchronous programming in TypeScript
  */

  // This is an async function
  async function getDataById(uuid: number): Promise<string> {
      await new Promise(resolve => setTimeout(resolve, 1000))
      return `${uuid}: data`
  }


  // This is another async function that calls the other async function
  async function getDataWithUuid1(): Promise<string> {
      return await getDataById(1) // Once invoked with 'await', other tasks in the event loop are given chance to run
  }


  // Running concurrent tasks
  async function main(): Promise<void> {
      // Sequential execution
      const data1 = await getDataById(1)
      const data2 = await getDataById(2)

      // Concurrent execution with Promise.all
      const [res1, res2] = await Promise.all([
          getDataById(1),
          getDataById(2),
      ])

      // Promise.race - resolves with the first settled promise
      const fastest = await Promise.race([
          getDataById(1),
          getDataById(2),
      ])
  }

  main()
  ```

# Parallelism

JavaScript/TypeScript runs on a single-threaded event loop (in Node.js or the browser).
True parallelism requires Worker Threads (Node.js) or Web Workers (browser).
However, the most interesting part in this subject is race conditions, along with the problems that follow in order to prevent it.

When using shared memory (via `SharedArrayBuffer`), it's easy to write code that contains race conditions.
Here are some generic remedies.

- Use `Atomics` API for atomic operations on shared memory.
- Use message passing between workers instead of shared memory when possible.
- Design tasks to be independent, avoiding shared state entirely.

There are other paradigms to avoid race conditions, however, it is only worth mentioning them to the interviewer to demonstrate your knowledge of options.

- Actors
- Purely Functional Programming

```typescript
...

import { Worker, isMainThread, parentPort, workerData } from 'worker_threads'
import { Semaphore } from 'async-mutex' // npm package for async semaphores


/*
Worker Threads (Node.js)
*/
if (isMainThread) {
    const worker = new Worker(__filename, { workerData: { task: 'compute' } })
    worker.on('message', (msg) => console.log('Result:', msg))
    worker.on('error', (err) => console.error(err))
} else {
    // Worker thread code
    const result = workerData.task
    parentPort?.postMessage(result)
}

/*
Semaphores (using async-mutex library)
*/
// Semaphores limit concurrent access. Up to 5 tasks can acquire this Semaphore
const sem = new Semaphore(5)
async function limitedTask(): Promise<void> {
    const [, release] = await sem.acquire()
    try {
        // ... critical section
    } finally {
        release()
    }
}

/*
Atomics for shared memory (low-level parallelism)
*/
const sharedBuf = new SharedArrayBuffer(4)
const sharedArr = new Int32Array(sharedBuf)
Atomics.add(sharedArr, 0, 1) // Atomic increment
Atomics.load(sharedArr, 0) // Atomic read
Atomics.store(sharedArr, 0, 42) // Atomic write
```

There are other convenient synchronization primitives that libraries like `async-mutex` provide, such as `Mutex` and `Semaphore`.
For deeper understanding of concurrency primitives, please refer to open-source material, [*Little Book of Semaphores*](https://greenteapress.com/wp/semaphores) for details on how Semaphores are composed to solve race conditions and deadlocks for various problems.
Chapter 4. Classical Synchronization Problems will be enough to understand the basics.

### Database Isolation Levels

As demonstrated above, race conditions that need to be resolved in memory apply the same way in database systems.
In particular, databases categorize these traits in terms of isolation levels and it is up to the programmer which one to use for the application based on the pros and cons.

Before going into each isolation level, here is a small glossary.

- Query:
  Single database operation
- Transaction:
  Entire transaction that may be composed of several Queries

#### Read Committed (Using Locks)

- No dirty read / writes (all other committed transactions are shown during current transaction).
  - Readers and writers block each other by using single lock to a row during the query.
  - Phantoms may show in read-only queries during transaction (read-skew).
  - Phantoms may show in series of read-modify-write queries during transaction (write-skew).
- Lost updates can happen on read-modify-and-write (race condition).
  - Need to use either lock (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control) on the row(s) in the write query (and error-prone) during the transaction.
    When using compare-and-set, high contention towards the same row can lead to a lot of transaction restarts.

#### Read Committed (Using MVCC)

- No dirty read / writes (all other committed transactions are shown during current transaction).
  - Readers do not block writer and writer does not block readers.
    Implementation may differ based on using (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control).
  - Phantoms may show in read-only queries during transaction (read-skew).
  - Phantoms may show in series of read-modify-write queries during transaction (write-skew).
- Lost updates can happen on read-modify-and-write (race condition).
  - Need to use either lock (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control) on the row(s) in the write query (and error-prone) during the transaction.
    When using compare-and-set, high contention towards the same row can lead to a lot of transaction restarts.

#### Snapshot Isolation (Using MVCC)

- No dirty read / writes (only rows of committed transactions before the current transaction are shown).
  - Readers do not block writer and writer does not block readers.
    Implementation may differ based on using (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control).
  - Phantoms **DO NOT** show in read-only queries during transaction (read-skew).
  - Phantoms may show in some read-modify-write queries during transaction (write-skew).
- Lost updates can happen on read-modify-and-write (race condition).
  - Need to use either lock (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control) on the row(s) in the write query (and error-prone) during the transaction.
    When using compare-and-set, high contention towards the same row can lead to a lot of transaction restarts.

#### Serialized (Pessimistic Concurrency Control in transaction level)

- No dirty read / writes (other transactions **CANNOT** happen in parallel), lost updates, phantoms.
  - Readers and writer both block each other by using single lock to a row during the transaction (Notice the difference from Read Committed, that it's the entire transaction).
    Most widely known locks are 'Two-Phase Lock (2PL)', 'Predicate Lock' and 'Index-Range Lock'. They all suffer from performance penalty due to locks.

#### Serializable Snapshot Isolation (Optimistic Concurrency Control in transaction level)

- No dirty read / writes (other transactions **CAN** happen in parallel), lost updates, phantoms.
  - Implements special algorithm that detects all other affected transactions when write is committed during the transaction (and potentially restart them).
  - High contention towards the same row can lead to a lot of transaction restarts.

# Remarks on Concurrency and Parallelism

It's best to combine both asynchronous and parallel programming for optimization.
For example,
- If your application is mostly waiting on IO (disk access, network, etc.), concurrency will be enough; however, you would want to minimize thread waiting time through asynchronous programming.
- If your application is composed of tasks that are not overlapping in general, parallel programming can be a boon.

Modern web applications are a good example of a mix of both, where each request is served in parallel however, each thread does not block on IO.
