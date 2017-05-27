# Meow

Meow is the command group (task) management tool.

## Example

At first, use `init` command to initialize Meow.

```bash
> meow init
```

Create a task file and add some command.

The Task file is placed in `[your-home-dir]/.meow/tasks/`.

```bash
> meow new hello
> meow add hello "echo 'Hello Meow!'"
> meow add hello "cd ~/.meow/tasks"
> meow add hello "find . -name \"*meow\""
```

Run this task.

```bash
> meow run hello
Hello Meow!
./haskell.meow
./hello.meow
./test.meow
```

## Installation

Meow can be installed from sources with [stack](http://haskellstack.org/).

```
git clone git@github.com:ku00/meow.git
cd meow
stack build && stack install
meow --help
```
