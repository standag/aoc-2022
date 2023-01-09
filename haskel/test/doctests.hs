module Main where

import Test.DocTest

main :: IO ()
main = doctest ["-Lcabal-dev/lib", "-package-db dist-newstyle/packagedb/ghc-9.4.2/", "-isrc", "src/MyLib.hs", "src/day00.hs", "src/day01.hs", "src/day02.hs"]
