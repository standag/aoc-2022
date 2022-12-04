module Day04 (solvePartOne, solvePartTwo) where

inputFile :: IO String
inputFile = readFile "input/day04.txt"

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- 507
solvePartOne :: IO Int
solvePartOne = solvePartOne' <$> inputFile

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8"
-- 2
solvePartOne' :: String -> Int
solvePartOne' pairs = length $ filter fullOverlapped $ map parse $ lines pairs

-- |
-- Solve part two.
--
-- >>> solvePartTwo
-- 897
solvePartTwo :: IO Int
solvePartTwo = solvePartTwo' <$> inputFile

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo' "2-4,6-8\n2-3,4-5\n5-7,7-9\n2-8,3-7\n6-6,4-6\n2-6,4-8"
-- 4
solvePartTwo' :: String -> Int
solvePartTwo' pairs = length $ filter overlapped $ map parse $ lines pairs

replace :: Eq a => a -> a -> [a] -> [a]
replace a b = map $ \c -> if c == a then b else c

-- |
-- Parse input area.
--
-- >>> parse "10-12,99-100"
-- [10,12,99,100]
parse :: String -> [Int]
parse l = map (\x -> read x :: Int) $ words $ replace '-' ' ' $ replace ',' ' ' l

-- |
-- Test is the fullOverlapped.
--
-- >>> fullOverlapped [6,6,4,6]
-- True
-- >>> fullOverlapped [5,7,7,9]
-- False
fullOverlapped :: [Int] -> Bool
fullOverlapped (x1 : x2 : y1 : y2 : _) = (x1 <= y1 && x2 >= y2) || (x1 >= y1 && x2 <= y2)
fullOverlapped _ = False

-- |
-- Test if areas are overlapped.
--
-- >>> overlapped [5,7,7,9]
-- True
overlapped :: [Int] -> Bool
overlapped (x1 : x2 : y1 : y2 : _) = (y1 <= x1 && x1 <= y2) || (y1 <= x2 && x2 <= y2) || (x1 <= y1 && y1 <= x2) || (x1 <= y2 && y2 <= x2)
overlapped _ = False
