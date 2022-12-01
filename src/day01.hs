module Day01 (solvePartOne, solvePartTwo) where

import Data.List.Split
import Data.List

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- 68467 
solvePartOne :: IO Int
solvePartOne = solvePartOne' <$> readInputFile

-- | Pure solution of part one.
--
-- >>> solvePartOne' "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
-- 24000
solvePartOne' :: String -> Int
solvePartOne' xs = maximum $ map sum $ parse xs

-- |
-- Solve part two.
--
-- >>> solvePartTwo
-- 203420
solvePartTwo :: IO Int
solvePartTwo = solvePartTwo' <$> readInputFile

-- | Pure solution of part two.
--
-- >>> solvePartTwo' "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
-- 45000
solvePartTwo' :: String -> Int
solvePartTwo' xs = sum $ take 3 $ reverse $ sort $ map sum $ parse xs

readInputFile :: IO String
readInputFile = readFile "input/day01.txt"

parse :: String -> [[Int]]
parse xs = map (map read) $ splitOn [""] $ lines xs


