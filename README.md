# Leste

## A Powerful and User-Friendly Lua Testing Framework

Leste is a comprehensive Lua testing framework heavily inspired by PestPHP and pytest, aiming to simplify and streamline your testing process. With Leste, writing and running tests for your Lua codebase becomes straightforward and efficient.

The name Leste cleverly merges Lua (L) and teste (Portuguese for test), embodying the playful essence of its creation. Additionally, the word "leste" in Portuguese carries the meaning of "east". This serving as a subtle homage to Lua's Brazilian roots.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
  + [Command Syntax](#command-syntax)
  + [Arguments](#arguments)
  + [Options](#options)
  + [Examples](#examples)
- [Writing Tests](#writing-tests)
  + [1. Create a Tests Folder](#1-create-a-tests-folder)
  + [2. Create Test Files](#2-create-test-files)
  + [3. Write Test Cases](#3-write-test-cases)
  + [4. Run Tests](#4-run-tests)
  + [Example Test Execution](#example-test-execution)
- [Contribution](#contribution)
- [License](#license)

## Features

Leste offers the following features:

1. **Assertion Tracking**: Leste tracks the total number of assertions made during tests.
2. **Verbose Output**: Choose whether to display the output of the print function inside tests.
3. **Exit on First Failure**: Option to stop running tests after the first failure.
4. **Test Case Organization**: Easily organize test cases with beforeAll, afterAll, beforeEach, and afterEach hooks.
5. **CLI Interface**: Provides a CLI interface for running tests from the command line.
6. **Flexible Test Case Definition**: Define test cases using the `it` function, specifying a description and test function.
7. **Initialization and Cleanup**: Initializes the testing framework and cleans up after test execution.
8. **Detailed Test Reports**: Generates detailed test reports including test outcomes, execution time, assertions, and errors.
9. **Configurable Output**: Customize the output format based on verbosity settings.
10. **Integration with Lua Modules**: Seamlessly integrate Leste with Lua modules for testing Lua code.

With Leste, you can streamline your testing process and ensure the reliability of your Lua applications.

## Installation

To install Leste, follow these steps:

1. Clone the repository from GitHub:
   ```bash
   git clone https://github.com/AdaiasMagdiel/Leste.git
   ```

2. Navigate into the Leste directory:
   ```bash
   cd Leste
   ```

3. Create a script named `leste` (or `leste.bat` for Windows) pointing to the `leste/main.lua` file:
   - For Unix-like systems (Linux, macOS):
     ```bash
     #!/bin/bash

     lua path/to/leste/main.lua $*
     ```
   - For Windows:
     ```cmd
     @echo off

     lua path\to\leste\main.lua %*
     ```

4. Ensure the script is added to your system's PATH so it can be executed from anywhere.

## Usage

Leste provide a CLI interface for running tests using the testing framework.

### Command Syntax

```bash
leste [options] [folder]
```

### Arguments

- `folder`: (optional) Folder to find tests. Default is `./tests`.

### Options

- `-v, --verbose`: Display output of print function inside tests. Default is `false`.
- `-x, --exitfirst`: Exit on the first failure. Default is `false`.

### Examples

Run tests located in the default `./tests` folder with verbose output:

```bash
lua leste/main.lua -v
```

Run tests located in a specific folder:

```bash
lua leste/main.lua my_tests_folder
```

Stop the tests after the first failure:

```bash
lua leste/main.lua -x
```

## Writing Tests

### 1. Create a Tests Folder

First, create a folder named `tests` in your project directory. This folder will contain all your test files.

```bash
mkdir tests
```

### 2. Create Test Files

Inside the `tests` folder, create a Lua file for each set of tests you want to write. Ensure that each test file has a filename prefix of "test" so that Leste can discover and execute them. For example, `testExample.lua`.

### 3. Write Test Cases

In each test file, you can define multiple test cases using the `Leste.it` function. Each test case consists of a description and a function containing the test assertions.

Here's an example of a valid test file (`testExample.lua`):

```lua
local Leste = require("leste.leste")

-- Test case 1: A basic example
Leste.it("Remember to write an interesting and well-explained description about the test.", function()
    assert(true)
end)

-- Test case 2: Using print statements for debugging
Leste.it("You can add print statements if you need to debug, but remember to use the -v flag.", function()
    print("This message will appear in the test standard output.")
    assert(true)
end)
```

### 4. Run Tests

To execute the tests, use the Leste CLI interface. Navigate to your project directory in the terminal and run the following command:

```bash
leste -v
```

This command will automatically run all the test files (`test*`) located in the `tests` folder. You can also specify a specific folder to run tests from if needed.

Try to run the code without the verbose flag to observe how the print function is silenced.

```bash
leste
```

### Example Test Execution

After running the tests, you will see the test results displayed in the terminal, including passed and failed tests, execution time, and any assertions errors, general errors or debug output.

```bash
    PASS   Remember to write an interesting and well-explained description about the test.

    File:    testExample.lua
    Time:    0.00s
    Asserts: .

    PASS   You can add print statements if you need to debug, but remember to use the -v flag.

    File:    testExample.lua
    Time:    0.00s
    Asserts: .

STDOUT:
This message will appear in the test standard output. 


    ✓ All tests passed successfully

    Tests:      2 tests    2 passed    0 failed    (2 assertions)
    Duration:   0.00s
```

## Contribution

Contributions are welcome Please feel free to submit pull requests or open issues for any bugs or feature requests.

You can start selecting a task from the list in the [TODO.md](TODO.md) file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
