module Main where

import Test.DocTest

main :: IO ()
main = doctest ["src/MyLib.hs", "src/day00.hs"]
