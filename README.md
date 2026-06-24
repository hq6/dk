# dk

`dk` ( "discover kommand" ) organizes command line tools, making it easier to
discover them and view their documentation.

`dk` will look for executable scripts and binaries under directories named
`dkbin` in the current working directory and its parents.
 * Scripts must minimally contain have a `SUMMARY:` line  and a
   `HELP:` section after the shebang line. See `dkbin/hello-world-script` as an
   example of a script.
 * Binary executables must respond to `--summary` and `--help` with similar
   output. See `dkbin-src/hello-world-bin.c` as an example of a binary.
 * Both scripts and binaries should be robust to being invoked with
   `--complete`, minimally exiting with no output.

`dk` is useful for organizing simple cli tools, which can live in `$HOME/dkbin`.
`dk` is useful for organizing cli tools for working with a particular
repository , which can live in a `dkbin` directory at the root of the
repository.

## Installation
```
curl https://raw.githubusercontent.com/hq6/dk/refs/heads/master/bin/install-latest-release.sh | bash
```
### Verification

To verify the installation worked correctly, run the following commands in a
new terminal.

```
cd $HOME
mkdir dkbin
cat > dkbin/hello-world  <<EOF
#!/bin/bash
# SUMMARY: Say hello world
# HELP:
#
# USAGE
#    dk hello-world
echo "Hello dk!"
EOF
chmod u+x dkbin/hello-world
dk
```

If this output includes the following, then the dk was installed correctly.
```
USAGE
   dk <command> [<args>]

COMMANDS IN ~/dkbin
   hello-world  Say hello world

Run dk help <command> to print information on a specific command.
```
If `dk` is not found, please ensure that your `PATH` includes the install
directory.

---

To verify tab completion, run the following and ensure that your terminal
completes to `dk hello-world`.
```
dk hello-<TAB>
```

If tab completion is failing, please ensure that on-screen instructions printed
by the install script have been followed.

## Usage

Put executable scripts and binaries in `dkbin` to make them discoverable by `dk`.
Run `dk` to list available commands.
Run `dk help <command>` to get help.

## Appendix

### What problem does `dk` solve?
 * When I first started writing utilty scripts and short programs for both
   personal and work purposes, I would lose track of where I put them or forget
   that they existed at all.
 * At some point, I tried to put all my scripts in a single directory. This
   prevented the loss of scripts but it was still easy to forget that they
   existed at all. Also, sometimes scripts are intended for use with a
   particular project and thus do not belong in a centralized place.
 * Additionally, getting at the documentation for scripts typically required
   reading the file, since the documentation for such short scripts is often in
   the form of a comment.
 * With `dk`, I put all my general purpose scripts in `$HOME/dkbin`, and put
   all my project-specific scripts in a `dkbin` directory at the project
   root. When I need to determine whether I already have a script that does X,
   I type `dk` to determine which scripts exist and what they are intended to
   do. I type `dk help <command>` to automatically extract the comment.

### Gotchas

`dk` makes 3 assumptions about the scripts within its domain, and if these
assumptions are incorrect, undesirable behavior may occur:
 * When invoked without arguments, `dk` will invoke any executable script
   inside a `dkbin` directory with `--summary` iff there is no `SUMMARY: `
   line.
 * When invoking `dk help <command>`, `dk` will invoke `command`
   with `--help` iff there is no `HELP:` line.
 * When invoking `dk <command> <TAB>`, `dk` will invoke `command` with `--complete`.

If the script lacks the magic comments AND is not expecting to be called with
`--summary`, `--help` or `--complete`, it may exhibit surprising behavior.
For example, if the first argument is treated as a filename for writing output,
this may cause the creation of a file named `--summary`.

### Uninstall
```
curl https://raw.githubusercontent.com/hq6/dk/refs/heads/master/bin/uninstall.sh | bash
```

### Acknowledgements

`dk` is inspired by the internal tool `sq` built at Block and based on the same
[exoskeleton](https://github.com/square/exoskeleton) library, although it was
implemented without reference to that tool's source code.
