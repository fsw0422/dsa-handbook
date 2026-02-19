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
- Coroutines / Async-Await:
  Async-Await paradigm takes a different approach where the language provides its own building blocks using Promises.
  Each `await` call will suspend the caller function until the Promise resolves, but never blocks the event loop underneath so that it can immediately start executing other tasks.
  This is similar to the way processes or threads are rescheduled by the operating system scheduler, however async functions do not affect the operating system scheduler because from the operating system's point of view, the underlying thread is always active (thus context switches are cheap).
  Async-Await is also easier to debug than Callbacks and Reactive approaches.

```typescript
...

/**
 * We will be focusing on Async-Await, as it's the de-facto way of asynchronous programming in TypeScript/JavaScript
 */

// This is a single async function
async function getDataById(uuid: number): Promise<string> {
    await new Promise(resolve => setTimeout(resolve, 1000));
    return `${uuid}: data`;
}

// This is another async function that calls the other async function
async function getDataWithUuid1(): Promise<string> {
    return await getDataById(1); // Once invoked with 'await', other tasks are given chance to be run on the event loop
}

getDataWithUuid1().then(console.log);

/**
 * Running multiple async operations concurrently
 */
async function getAllData(): Promise<string[]> {
    // Promise.all runs all promises concurrently and waits for all to complete
    return await Promise.all([
        getDataById(1),
        getDataById(2),
        getDataById(3),
    ]);
}

// Promise.race returns the result of the first promise to resolve
async function getFirstData(): Promise<string> {
    return await Promise.race([
        getDataById(1),
        getDataById(2),
    ]);
}
```

# Parallelism

TypeScript/JavaScript is single-threaded (using the event loop model).
True parallelism is achieved through Web Workers (browser) or Worker Threads (Node.js).
However, the most interesting part in this subject is race conditions, along with the problems that follow in order to prevent it.

Since JavaScript is single-threaded, traditional race conditions from multi-threading don't occur within a single event loop.
However, race conditions can still happen with shared resources (e.g., databases, files) or when using Worker Threads.

When using locks, it's easy to write code that contains Deadlocks.
Here are some generic remedies.

- Prevent it from happening by using timeouts when acquiring locks.
- Detect-and-cure by maintaining a dependency graph for threads and periodically check cycles.

There are other paradigms to avoid race conditions, however, it is only worth mentioning them to the interviewer to demonstrate your knowledge of options.

- Actors
- Purely Functional Programming

```typescript
...

/**
 * Worker Threads (Node.js)
 *
 * For CPU-intensive tasks that need true parallelism
 */
import { Worker, isMainThread, parentPort, workerData } from 'worker_threads';

if (isMainThread) {
    const worker = new Worker(__filename, { workerData: { task: 'compute' } });
    worker.on('message', (result) => console.log(result));
    worker.on('error', (err) => console.error(err));
} else {
    // Worker thread code
    parentPort?.postMessage('done');
}

/**
 * Semaphore (custom implementation for async context)
 *
 * Since JS is single-threaded, semaphores are used to limit concurrent async operations
 */
class Semaphore {
    private count: number;
    private waiting: (() => void)[] = [];

    constructor(count: number) {
        this.count = count;
    }

    async acquire(): Promise<void> {
        if (this.count > 0) {
            this.count--;
            return;
        }
        return new Promise<void>(resolve => this.waiting.push(resolve));
    }

    release(): void {
        this.count++;
        if (this.waiting.length > 0) {
            this.count--;
            const next = this.waiting.shift()!;
            next();
        }
    }
}

// Usage: up to 5 concurrent operations
const sem = new Semaphore(5);
async function limitedTask(): Promise<void> {
    await sem.acquire();
    try {
        // ... critical section
    } finally {
        sem.release();
    }
}
```

There are other convenient concurrency primitives like `Mutex` that can be composed from Semaphores.
Please refer to open-source material, [*Little Book of Semaphores*](https://greenteapress.com/wp/semaphores) for details on how Semaphores are composed to solve race conditions and deadlocks for various problems.
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
  - Phantoms do not show in read-only queries during transaction (read-skew).
  - Phantoms may show in some read-modify-write queries during transaction (write-skew).
- Lost updates can happen on read-modify-and-write (race condition).
  - Need to use either lock (Pessimistic Concurrency Control) or compare-and-set (Optimistic Concurrency Control) on the row(s) in the write query (and error-prone) during the transaction.
    When using compare-and-set, high contention towards the same row can lead to a lot of transaction restarts.

#### Serialized (Pessimistic Concurrency Control in transaction level)

- No dirty read / writes (other transactions cannot happen in parallel), lost updates, phantoms.
  - Readers and writer both block each other by using single lock to a row during the transaction (Notice the difference from Read Committed, that it's the entire transaction).
    Most widely known locks are 'Two-Phase Lock (2PL)', 'Predicate Lock' and 'Index-Range Lock'. They all suffer from performance penalty due to locks.

#### Serializable Snapshot Isolation (Optimistic Concurrency Control in transaction level)

- No dirty read / writes (other transactions can happen in parallel), lost updates, phantoms.
  - Implements special algorithm that detects all other affected transactions when write is committed during the transaction (and potentially restart them).
  - High contention towards the same row can lead to a lot of transaction restarts.

# Remarks on Concurrency and Parallelism

It's best to combine both asynchronous and parallel programming for optimization.
For example,
- If your application is mostly waiting on IO (disk access, network, etc.), concurrency will be enough; however, you would want to minimize thread waiting time through asynchronous programming.
- If your application is composed of tasks that are not overlapping in general, parallel programming can be a boon.

Modern web applications are a good example of a mix of both, where each request is served in parallel however, each thread does not block on IO.
In TypeScript/JavaScript's case, the single-threaded event loop handles concurrency natively, while Worker Threads provide parallelism for CPU-bound tasks.
