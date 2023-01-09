module Day03 (solvePartOne, solvePartTwo) where

import Data.List (elemIndex, intersect)

inputFile :: IO String
inputFile = readFile "input/day03.txt"

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- 7817
solvePartOne :: IO Int
solvePartOne = solvePartOne' <$> inputFile

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"
-- 157
solvePartOne' :: String -> Int
solvePartOne' xs = sum $ map rucksackScore $ lines xs

-- |
-- Solve part two.
--
-- >>> solvePartTwo
-- 2444
solvePartTwo :: IO Int
solvePartTwo = solvePartTwo' <$> inputFile

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo' "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"
-- 70
solvePartTwo' :: String -> Int
solvePartTwo' i = sum $ group'sBadges $ lines i

halve :: [a] -> ([a], [a])
halve xs = splitAt s xs
  where
    s = length xs `div` 2

rucksackScore :: String -> Int
rucksackScore xs = itemScore $ head $ uncurry intersect $ halve xs

score :: Maybe Int -> Int
score (Just s) = s + 1
score Nothing = error "Unknown item"

itemScore :: Char -> Int
itemScore c = score $ elemIndex c $ ['a' .. 'z'] ++ ['A' .. 'Z']


group'sBadges :: [String] -> [Int]
group'sBadges (x1:x2:x3:xs) = itemScore (head $ intersect x3 $ intersect x1 x2) : group'sBadges xs
group'sBadges _ = []
