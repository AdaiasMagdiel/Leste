# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2024-05-15

### Added

- Leste Core (`leste.leste`): This module offers core functionalities for creating and executing tests within your Lua codebase. 
- Leste Command-Line Interface (CLI) (`leste.main`): The Leste CLI simplifies test execution by automatically discovering test files prefixed with "test" within your project tests directory. It then executes those tests and provides informative output.
- Leste Utility Module (`leste.utils`): This module houses various utility functions to aid testing development. It includes:
    - `fs`: Functions for interacting with the filesystem, such as file manipulation.
    - `console`: Functions for handling console output, formatting test results, and potentially offering color customization in the future.
    - `cli`: Functions for managing command-line arguments and options passed to the Leste CLI.

[0.0.1]: https://github.com/AdaiasMagdiel/Leste/releases/tag/v0.0.1
