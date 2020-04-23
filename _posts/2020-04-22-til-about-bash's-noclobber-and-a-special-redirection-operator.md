---
layout: post
title: "TIL about bash's noclobber and a special redirection operator"
date: 2020-04-22
categories: development
link: https://unix.stackexchange.com/a/45203
---

Today I learned about a special redirection operator in bash: `>|`.

GNU Bash (and other POSIX-like shell environments) have a bunch of [built in options](https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html#The-Set-Builtin) that will modify the behavior of the environment when changed.
One of these is the `noclobber` option that prevents redirecting `stdout` of a command to overwrite a file if it already exists:

```sh
λ › ls CNAME
CNAME
λ › echo "This will fail" > CNAME
zsh: file exists: CNAME
```

You can see the value of this shell option by using the `set -o` command:

```sh
λ › set -o | rg noclobber
noclobber             on
```

You can turn it off using `set +o` and suddenly you'll be able to overwrite files using a vanilla `stdout` redirect:

```sh
λ › set +o noclobber
λ › set -o | rg noclobber
noclobber             off
λ › echo "This will work" > CNAME
λ › echo $?
0
```

This is usually enabled by default because _safety_.

But there's also a way to explicitly override this setting - enter `>|`!

```sh
λ › ls CNAME
CNAME
λ › echo "This works too" >| CNAME
λ › echo $?
0
```

I learned this when building a bunch of scripts to help me analyze some source code that someday I hope to share.
Specifically, I was getting tired of having to delete a file before re-running the script during development.
This allowed me to make my commands more concise.

From this I learned of `noclobber` and the shell builtin optiens!

DISCLAIMER: I actually learned about this last week but thought it wa sworth sharing.  I'm surprised at how long it took me to find this!
