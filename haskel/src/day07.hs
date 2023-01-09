module Day07 (solvePartOne, solvePartTwo) where

import qualified Data.HashMap as HM

inputFile :: IO String
inputFile = readFile "input/day07.txt"

-- |
-- Solve part one.
--
-- >>> solvePartOne
--
solvePartOne :: ()
solvePartOne = ()

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "$ cd /\n$ ls\ndir a\n14848514 b.txt\n8504156 c.dat\ndir d\n$ cd a\n$ ls\ndir e\n29116 f\n2557 g\n62596 h.lst\n$ cd e\n$ ls\n584 i\n$ cd ..\n$ cd ..\n$ cd d\n$ ls\n4060174 j\n8033020 d.log\n5626152 d.ext\n7214296 k"
-- 0
solvePartOne' :: String -> Int
solvePartOne' input = parse input

-- |
-- Solve part two.
--
-- >>> solvePartTwo
--
solvePartTwo :: ()
solvePartTwo = ()

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo'
--
solvePartTwo' :: ()
solvePartTwo' = ()


parse :: String -> HM.Map String Int
parse input = 
