module Day06 (solvePartOne, solvePartTwo) where

import Data.List

inputFile :: IO String
inputFile = readFile "input/day06.txt"

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- 1779
solvePartOne :: IO Int
solvePartOne = solvePartOne' <$> inputFile

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
-- 7
-- >>> solvePartOne' "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
-- 11
solvePartOne' :: String -> Int
solvePartOne'= findPacket 4 4


-- |
-- Solve part two.
--
-- >>> solvePartTwo
-- 2635
solvePartTwo :: IO Int
solvePartTwo = solvePartTwo' <$> inputFile

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo' "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
-- 19
solvePartTwo' :: String -> Int
solvePartTwo' = findPacket 14 14

findPacket :: Int -> Int -> String -> Int
findPacket n i buffer = if hasDuplicates $ take n buffer then findPacket n (i + 1) (tail buffer) else i

hasDuplicates :: (Ord a) => [a] -> Bool
hasDuplicates xs = length (nub xs) /= length xs
