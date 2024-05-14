# Leste

## A Powerful and User-Friendly Lua Testing Framework

Leste is a comprehensive Lua testing framework heavily inspired by PestPHP and pytest, aiming to simplify and streamline your testing process.

The name "Leste" playfully combines Lua ("L") and "teste" (Portuguese for "test") while coincidentally referencing the east direction ("leste" in Portuguese) – a subtle nod to Lua's Brazilian origin.

## Features

- **Clear and Concise Syntax:** The `it` function allows for easy definition of test cases with descriptive names.
- **Enhanced Readability:** Colored output highlights successful and failed tests, aiding in visual identification.
- **Customizable Configuration:** Control verbosity (print output) and early termination behavior (exit on first failure) using command-line options.
- **Multiple Test File Support:** Locate test files either in the default `tests` directory or within a specified folder.

## Installation

Currently, Leste is available through cloning the GitHub repository. In the future, it will be integrated with luarocks for a more convenient installation process.

1. First Clone the repository:

   ```bash
   git clone https://github.com/AdaiasMagdiel/Leste.git
   ```

One option is to create a `leste` or `leste.bat` file that points to
the `lest/main.lua` script and add it to your system's PATH for easy access.

file: `leste`
```bash
#!/bin/bash

lua path/to/the/lest/folder/main.lua $*
```

file: `leste.bat`
```cmd
@echo off

lua path\to\the\lest\folder\main.lua %*
```

## Documentation

For a more detailed and comprehensive overview of Leste's usage and features, please refer to the official documentation available at [https://adaiasmagdiel.github.io/Leste/](https://adaiasmagdiel.github.io/Leste/).

## Examples

You can run some test examples in the `example-tests` folder:

```bash
lua path/to/the/lest/folder/main.lua example-tests
```

The folder contains files with assertions that will fail and assertions that will pass.

## Usage

1. **Define Your Tests:**

   Create Lua files (named with the `test` prefix) within your project's `tests` directory (or a custom folder) and use the `it` function to structure your test cases:

   ```lua
   -- tests/test_example.lua
   local Leste = require("leste.leste")

   Leste.it("This should be true", function()
       assert(1 == 1)
   end)

   Leste.it("This should be false", function()
       assert(1 == 2) -- This assertion will fail
   end)
   ```

2. **Run the Tests:**

   Execute the following command from the terminal:

   ```bash
   lua leste/main.lua [folder]  # Optional: Specify a custom test folder
   ```

   If you omit the `folder` argument, the default `tests` directory will be searched for test files.

### Command-Line Options

- `-v`, `--verbose`: Display the output of the `print` function within tests for debugging purposes. Defaults to `false`.
- `-x`, `--exitfirst`: Stop running tests after the first failure occurs. Defaults to `false`.

### Example Output

Here's a sample output demonstrating both successful and failing tests:

```
   ✓ All tests passed successfully (2 assertions)

   Tests:      2 tests          1 passed          1 failed  (2 assertions)
   Duration:   0.01s
```

## Contribution

Contributions are welcome Please feel free to submit pull requests or open issues for any bugs or feature requests.

You can start selecting a task from the list in the [TODO.md](TODO.md) file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
