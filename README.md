# Advent of Code 2022 [Haskell]

## Install

## Haskell toolchain installer

`brew install ghcup`

Alternatively, it can be install by:

`curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`

## Compiler and Cabal (Haskell project manager)

```
ghcup install ghc 9.4.2
ghcup set ghc 9.4.2
ghcup install cabal latest
cabal update
ghcup install hls latest
```

Note: ghc 9.4.3 (latest) ins't supported by latest language server (1.8.0)

## Editor (NVim) intergration

nvim+Mason: `MasonInstall haskell-language-server`

There is also plugin, maybe I should test it. # TODO

## Run

`cabal test`

### How?

Some old [unit tests integration to cabal.](https://github.com/kazu-yamamoto/unit-test-example/blob/master/markdown/en/tutorial.md)
The guide is a little bit old but both test frameworks look good.



