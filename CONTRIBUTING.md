# Contributing

This is the Homebrew tap for the Engram CLI (`brew install get-engram/engram/engram`).
The formula tracks releases of [`@getengram/cli`](https://github.com/get-engram/engram).

Product bugs belong in the [main engram repo](https://github.com/get-engram/engram/issues) —
this repo is only for formula problems (install failures, version bumps).

To test a formula change locally:

```bash
brew install --build-from-source ./Formula/engram.rb
brew test engram
brew audit --strict engram
```
