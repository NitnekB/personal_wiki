# Quick Review - difference between block/proc/lambda

All this talk of blocks, procs, and lambdas might have your head spinning. Let’s take a minute to clarify exactly what each one is:

* A block is just a bit of code between do..end or {}. It’s not an object on its own, but it can be passed to methods like .each or .select.
* A proc is a saved block we can use over and over.
* A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.

There are obviously lots of cases in which blocks, procs, and lambdas can do similar work, but the exact circumstances of your program will help you decide which one you want to use.
