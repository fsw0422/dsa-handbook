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
- Coroutines:
  Coroutines paradigm take a different approach where the language provides its own building blocks of the program with something called Coroutines.
  Each Coroutine call will suspend the caller Coroutine until it finishes, but never blocks the thread underneath so that the thread can immediately start executing other Coroutines.
  This is similar to the way processes or threads are rescheduled by the operating system scheduler, however Coroutines do not affect the operating system scheduler because from the operating system's point of view, the underlying thread is always active (thus Coroutines switches are cheap).
  Coroutines are also easier to debug than Callbacks and Reactive approaches.

  ```python
  ...
  
  import asyncio
  import time
  
  
  """
  We will be focusing on Coroutines, as it's the de-facto way of asynchronous programming today
  """
  
  # This is a single Coroutine block
  async def get_data_by_id(uuid: int) -> str:
      time.sleep(1)
      return f'{uuid}: data'
  
  
  # This is another Coroutine block that calls the other Coroutine
  async def get_data_with_uuid_1() -> str:
      return await get_data_by_id(1) # Once invoked with 'await', other Coroutines are given chance to be run
  
  
  loop = asyncio.get_event_loop()
  loop.run_until_complete(get_data_with_uuid_1())
  ```

# Parallelism

Parallel programming can greatly enhance performance of a program if tasks have minimal dependencies and overlapping tasks.
However, the most interesting part in this subject is race conditions, along with the problems that follow in order to prevent it.

When using locks, it's easy to write code that contains Deadlocks.
Here are some generic remedies.

- Prevent it from happening by using timeouts when acquiring locks.
- Detect-and-cure by maintaining a dependency graph for threads and periodically check cycles.

However, careful use of locks must be practiced before relying on generic remedies.

There are other paradigms to avoid race conditions, however, it is only worth mentioning them to the interviewer to demonstrate your knowledge of options.

- Actors
- Purely Functional Programming

```python
...

from threading import Thread, Semaphore


"""
Threads

We assume free-thread Python (GIL turned off)
"""
thread = Thread()

"""
Semaphores
"""
# Semaphores have internal counter where if it goes down to a negative value, it will block (no busy-wait) the thread until a resource is available
sem = Semaphore(5) # Up to 5 threads can acquire this Semaphore.
with sem:
    ...
```

There are other convenient locks such as `Lock()`, `Rlock()` or `Condition()` that Python provides, however you can do the same (or similar) by composing multiple Semaphores.
Please refer to open-source material, [*Little Book of Semaphores*](https://greenteapress.com/wp/semaphores) for details on how Semaphores are composed to solve race conditions and deadlocks for various problems.
Chapter 4. Classical Synchronization Problems will be enough to understand the basics.

### Database Isolation Levels

As demonstrated above in Python code, race conditions that need to be resolved in memory apply the same way in database systems.
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
