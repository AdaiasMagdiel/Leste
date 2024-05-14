# TODO

There are some ideas to add to the project. You can add a new idea or work
on an idea from here.

### leste/leste.lua

- Change the assert function (in Leste.run):
  - Store the assertions to verify later which ones have failed.
  - Currently, we only know that it has failed, but not where.

- Print a warning if there are no assertions.

- Implement methods to run functions:
  - beforeEachTest
  - afterEachTest
  - beforeAllTests
  - afterAllTests.

### tests/dummy_leste.lua

- Disable stdout for DummyLeste, it should only run the methods without reporting.