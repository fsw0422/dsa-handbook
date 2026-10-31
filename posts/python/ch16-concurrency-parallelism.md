# Concurrency

Concurrency lets multiple tasks make progress during overlapping periods, even on a single CPU core.
When one task waits for I/O, another can do useful work.
Threads consume memory, and switching between them adds overhead.
Asynchronous I/O can handle many waiting operations with fewer threads.

Common ways to organize asynchronous work include:

- Callbacks:
  Register a function to run when an operation completes or an event occurs.
  A callback does not by itself make a blocking operation asynchronous.
  Deeply nested callbacks can make control flow difficult to follow.
- ReactiveX:
  Compose streams of values or events using operations such as filtering and mapping.
  The source and scheduler determine where and when the work runs.
- Coroutines:
  Use `async` and `await` to suspend and resume work.
  In Python's `asyncio`, calling a coroutine function creates a coroutine object; await it or schedule it as a task to run it.
  An `await` can yield control while waiting, but a result that is already available may return without switching tasks.
  Blocking calls such as `time.sleep()` still block the event-loop thread.

  ```python
  ...
  
  import asyncio
  from typing import List
  
  
  async def get_data_by_id(item_id: int) -> str:
      await asyncio.sleep(1) # Simulate waiting for I/O while allowing other tasks to run.
      return f'{item_id}: data'
  
  
  async def main() -> List[str]:
      # Schedule both coroutines concurrently and return results in input order.
      return await asyncio.gather(get_data_by_id(1), get_data_by_id(2))
  
  
  asyncio.run(main()) # Returns: ['1: data', '2: data']
  ```

Use `asyncio.run()` as the entry point of a normal Python script.
If an event loop is already running in the same thread, await `main()` instead.
For blocking I/O without an async API, `asyncio.to_thread()` can run the operation in a worker thread.

# Parallelism

Parallelism means multiple tasks execute at the same time, usually on different CPU cores.
It can speed up computation when tasks can be divided and coordination costs remain manageable.

Within a CPython interpreter with the GIL enabled, only one thread executes Python bytecode at a time.
CPU-heavy Python work can use multiple processes or a free-threaded build with the GIL disabled.
Native extensions that release the GIL can also run work in parallel.

Both concurrency and parallelism can cause race conditions when tasks share mutable state.
Protect shared updates with synchronization, or reduce the amount of shared mutable state.

A deadlock can occur when tasks wait for resources held by each other.

- Acquire multiple locks in a consistent order.
- Keep locked sections small and use context managers to release locks even when an exception occurs.
- A timeout limits waiting, but it does not by itself prevent deadlocks.
  Handle the failure and release locks if you abandon the operation.
- Systems such as databases can detect cycles of lock waits and abort a transaction to let others continue.

Other approaches can reduce shared-state coordination:

- Actors keep state private and communicate through messages.
- Pure functions and immutable data avoid shared updates.

```python
...

from threading import Thread, Semaphore
import time


# A semaphore blocks acquisition when its counter is zero and never makes it negative.
sem = Semaphore(5)


def worker() -> None:
    with sem: # At most five workers can be inside this block at once.
        time.sleep(0.1) # Simulate blocking I/O in a worker thread.


threads = [Thread(target=worker) for _ in range(10)]
for thread in threads:
    thread.start() # Start the worker in another thread.
for thread in threads:
    thread.join() # Wait for the worker to finish.
```

These threads overlap blocking I/O; the example does not depend on disabling the GIL.
Use `Lock` for mutual exclusion, `RLock` when the same thread must acquire a lock repeatedly, and `Condition` to wait for changes to shared state.
For synchronization patterns, see [The Little Book of Semaphores](https://greenteapress.com/wp/semaphores).
Chapter 4 of that book covers classical synchronization problems.

For database isolation levels, see the [Isolation Level Cheat Sheet](https://github.com/fsw0422/sd-handbook/blob/main/cheatsheets/isolation-level.md) in the System Design Handbook.

# Remarks on Concurrency and Parallelism

Choose an execution model based on where the program spends its time.

- For work that mostly waits on I/O, consider asynchronous I/O or a bounded thread pool.
- For CPU-heavy work, consider parallel execution across processes or suitable threads, accounting for coordination and data-transfer costs.
- For mixed workloads, combine these approaches when measurements show a benefit.

For example, a web service may handle I/O concurrently in an event loop and send CPU-heavy tasks to worker processes.
