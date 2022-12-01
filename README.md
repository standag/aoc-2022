# Advent of Code 2022 [Haskell]

## Install

## Haskell toolchain installer

`brew install ghcup`

Alternatively, it can be install by:

`curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh`

## Compiler and Cabal (Haskell project manager)

```
ghcup install ghc 9.2.4
ghcup set ghc 9.2.4
ghcup install cabal latest
cabal update
cabal install cabal-install
cabal install doctest
ghcup install hls latest
```

Note: ghc 9.4.3 (latest) and 9.2.5 isn't supported by latest language server (1.8.0)
Note: hls with 9.4.2 doesn't support multiple plugins -> ghs==9.2.4

## Editor (NVim) intergration

nvim+Mason: `MasonInstall haskell-language-server`

There is also plugin, maybe I should test it. # TODO

## Run

`cabal build --write-ghc-environment-files=always`
`cabal test`

or

`doctest src/day01.hs`

### How?

Some old [unit tests integration to cabal.](https://github.com/kazu-yamamoto/unit-test-example/blob/master/markdown/en/tutorial.md)
The guide is a little bit old but both test frameworks look good.



