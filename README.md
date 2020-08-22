# Corral

A Pony dependency management command-line tool.

Keep your ponies in a corral to prevent them from getting lost.

<a href="http://clipart-library.com/clipart/488719.htm">
  <img src="http://clipart-library.com/image_gallery/488719.png" width="346" height="161" />
</a>

## Status

[![Actions Status](https://github.com/ponylang/corral/workflows/vs-ponyc-latest/badge.svg)](https://github.com/ponylang/corral/actions)

Corral is beta level software.

## About Corral

Corral is a dependency management tool for [Pony](https://www.ponylang.io). Corral:

* Provides extensibility for VCS and Commands.
* Supports semver version constraints on dependencies.
* Supports transitive dependencies.
* Supports revision locking on dependencies using a lock.json file.
* Uses a distinct shared VCS repo pool from per-project dependency workspace tree.
* Uses the Pony process package for running external tools like Git and ponyc.

### Design

See [Corral Design](doc/design.md) for more details about the design of Corral. Ongoing questions and notes for future work can be found in [Questions / Notes](doc/questions_notes.md)

### Background

Check out [Pony Package Dependency Management](doc/package_dependency_management.md) for a discussion of the research and requirements work behind Corral.

## Installation

Use [ponyup](https://github.com/ponylang/ponyup) to install corral.

The following command is assuming that `ponyup`, our toolchain multiplexer, is already installed on your machine and is available in your $PATH environment variable. If you don't have ponyup installed, please follow the [ponyup installation instructions](https://github.com/ponylang/ponyup#installing-ponyup).

```bash
ponyup update corral release
```

## Building From Source

See [BUILD.md](BUILD.md)

## Getting started using Corral

After installation, add Corral's current path to $PATH environment variable if you haven't already and follow these steps to create your first project using Corral.

1. Create the project. Make an empty folder and switch to this directory. This will be our example project to use Corral

```bash
mkdir myproject
cd myproject
```

2. Initialize Corral. It will create `corral.json` and `lock.json` files. At this moment they won't have much information since you haven't added any dependencies yet.

```bash
corral init
```

3. Add a dependency. This is the way to tell Corral that your project depends on this and you want to include it when building your project.

```bash
corral add github.com/ponylang/valbytes.git
```

4. Use a dependency. Create a file `main.pony` with following code.

```pony
use "valbytes"

actor Main
  new create(env: Env) =>
    var buf: ByteArrays = ByteArrays
    buf = buf + "!!" + "Hello," + " " + "World!"
    let greetings = buf.drop(2).string()
    env.out.print(greetings)
```

5. Fetch dependencies. The example Pony code is using `ByteArrays` type which is defined in the dependency which you have just added. Pony needs to have the source code of `ByteArrays` type to compile successfully. By fetching, Corral retrieves the source and makes it available when compiling the source code 

```bash
corral fetch
```

6. Build the project. Corral will now use this information to build the project. The command below act as a wrapper for `ponyc`

```bash
corral run -- ponyc
```

If there are no errors generated then an executable `myproject` will be created in the same folder.

You will also notice that there are two new folders `_corral` and `_repos` in your project folder now. They were generated by the `corral fetch` command. Please make sure to include them in your `.gitignore` file as there is no need to keep them in a versioning system since they are maintained by Corral itself.


## Documentation

See [DOCS.md](DOCS.md)
