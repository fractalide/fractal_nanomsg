# Nanomsg

## Project Description:

Critical messaging needed for inter service communications.

## Problem:

No means to communicate Capnproto messages between polyglot services.

## Solution:

Nanomsg makes a good messaging channel to send Capnproto schema.

## Trouble:

Doesn't build as the nanomsg crate fails to build when using [nixcrates](github.com/fractalide/nixcrates)

## Stability Status:

- [x] Raw
- [ ] Draft
- [ ] Stable
- [ ] Deprecated
- [ ] Legacy

## Build Instructions
Ensure you've installed [nix](https://nixos.org/nix).
```
$ export NIX_PATH+=:fractalide=https://github.com/fractalide/fractalide/archive/v20170220.tar.gz
$ git clone git://github.com/fractalide/fractal_nanomsg.git
$ cd fractal_nanomsg
$ nix-build --argstr rs test
```
