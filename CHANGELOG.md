# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.2] - 2024-05-16

### Added

- Help option to the CLI. Use `-h` or `--help` with `leste` to display the usage message.
- Expanded Assertion Functions in the `leste.assertions.Assertions` Module:
    - Introduced `notAssert` function to verify a condition is false.
    - Enhanced `equal` function for clearer error messages and refined comparisons.
    - Included `notEqual` function to assert expected and actual values as unequal.
    - Introduced `tableHasKey` function to validate the presence of a key in a table.
    - Added `tableNotHasKey` function to verify the absence of a key in a table.
    - Implemented `tableContains` function to verify if a table contains a specific value.
    - Added `tableNotContains` function to check if a table does not contain a specific value.
- Added comprehensive tests for the `leste.assertions.Assertions` module to ensure method quality.

[0.1.2]: https://github.com/AdaiasMagdiel/Leste/compare/v0.1.1...v0.1.2

## [0.1.1] - 2024-05-15

This release of Leste introduces several improvements to streamline the testing experience and provide more robust testing capabilities.

### Added

- LuaRocks Integration: Leste is now available on the LuaRocks repository! You can easily install it using the `luarocks install leste` command. This simplifies installation and ensures compatibility with your Lua environment.
- Leste.beforeAll and Leste.afterAll Hooks: Leste now offers `Leste.beforeAll` and `Leste.afterAll` hooks. These hooks execute specific code once before all tests in a test suite and once after all tests have run, respectively. This allows you to perform setup and teardown actions that apply to the entire test suite.
- Leste.beforeEach and Leste.afterEach Hooks: In addition to suite-level hooks, Leste introduces `Leste.beforeEach` and `Leste.afterEach` hooks. These hooks run before and after each individual test case, respectively. This enables you to perform actions specific to each test, such as initializing test data or cleaning up resources.

### Changed

- Enhanced Error Reporting: Leste now utilizes methods from the Assertions module for assertions. This improves the clarity and detail of error messages generated during test failures. You'll receive more informative feedback about the failing assertion and its location within your test code.

[0.1.1]: https://github.com/AdaiasMagdiel/Leste/compare/v0.1.0...v0.1.1

## [0.1.0] - 2024-05-15

### Added

- Leste Core (`leste.leste`): This module offers core functionalities for creating and executing tests within your Lua codebase. 
- Leste Command-Line Interface (CLI) (`leste.main`): The Leste CLI simplifies test execution by automatically discovering test files prefixed with "test" within your project tests directory. It then executes those tests and provides informative output.
- Leste Utility Module (`leste.utils`): This module houses various utility functions to aid testing development. It includes:
    - `fs`: Functions for interacting with the filesystem, such as file manipulation.
    - `console`: Functions for handling console output, formatting test results, and potentially offering color customization in the future.
    - `cli`: Functions for managing command-line arguments and options passed to the Leste CLI.

[0.1.0]: https://github.com/AdaiasMagdiel/Leste/releases/tag/v0.1.0
