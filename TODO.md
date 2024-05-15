# TODO

There are some ideas to add to the project. You can add a new idea or work
on an idea from here.

### leste/main.lua

- Add option to run a specific file (or files).
  - Maybe the [folder] argument can be [folder/file] (or [folder/files...]).
  - It's necessary to work in a way to verify if the argument is a folder or file, write a new method in leste.utils.fs.


### leste/assertions.lua

- Add more assertions methods to this module.

### leste/utils/cli.lua

- Refact the getFlags and getFlag.
  - use getFlag to get command line flags and add a optional parameter to remove or not from arg
    - Example: `local help = getFlag("h", "help", true)` args -> (short, long, remove)
