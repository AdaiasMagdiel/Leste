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

### leste/main.lua

- Add a flag to disable colors in output (--disable-color)
  - Maybe it is necessary to make modifications to the `leste/utils/console.format` function.
