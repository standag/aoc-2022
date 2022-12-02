module Day02 (solvePartOne, solvePartTwo) where

inputFile :: IO String
inputFile = readFile "input/day02.txt"

data RPS = Rock | Paper | Scissors deriving (Enum)

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- 14531
solvePartOne :: IO Int
solvePartOne = solvePartOne' <$> inputFile

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "A Y\nB X\nC Z"
-- 15
solvePartOne' :: String -> Int
solvePartOne' xs = sum $ map calcScore $ parse xs

parse :: String -> [[RPS]]
parse xs = map (map parseRPS . words) $ lines xs

parseRPS :: String -> RPS
parseRPS "A" = Rock
parseRPS "X" = Rock
parseRPS "B" = Paper
parseRPS "Y" = Paper
parseRPS "C" = Scissors
parseRPS "Z" = Scissors
parseRPS _ = error "Unknown symbol for Rock-Paper-Sciccors"

-- |
-- calc score
--
-- >>> calcScore [Rock, Paper]
-- 8
-- >>> calcScore [Paper, Rock]
-- 1
-- >>> calcScore [Scissors, Scissors]
-- 6
calcScore :: [RPS] -> Int
calcScore combo = calcWinScore combo + calcRPSScore (last combo)

calcRPSScore :: RPS -> Int
calcRPSScore Rock = 1
calcRPSScore Paper = 2
calcRPSScore Scissors = 3

calcWinScore :: [RPS] -> Int
calcWinScore [Rock, Paper] = 6
calcWinScore [Paper, Scissors] = 6
calcWinScore [Scissors, Rock] = 6
calcWinScore [Rock, Rock] = 3
calcWinScore [Paper, Paper] = 3
calcWinScore [Scissors, Scissors] = 3
calcWinScore _ = 0

-- |
-- Solve part two.
--
-- >>> solvePartTwo
-- 11258
solvePartTwo :: IO Int
solvePartTwo = solvePartTwo' <$> inputFile

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo' "A Y\nB X\nC Z"
-- 12
solvePartTwo' :: String -> Int
solvePartTwo' xs = sum $ map calcScore $ parse2 xs

parse2 :: String -> [[RPS]]
parse2 xs = map (parseRPS2 . words) $ lines xs

parseRPS2 :: [String] -> [RPS]
parseRPS2 (o : s : _) = [parseRPS o, calcStrategy (parseRPS o) s]
parseRPS2 _ = error "Malformatted input"

calcStrategy :: RPS -> String -> RPS
calcStrategy Rock "X" = Scissors
calcStrategy Rock "Y" = Rock
calcStrategy Rock "Z" = Paper
calcStrategy Paper "X" = Rock
calcStrategy Paper "Y" = Paper
calcStrategy Paper "Z" = Scissors
calcStrategy Scissors "X" = Paper
calcStrategy Scissors "Y" = Scissors
calcStrategy Scissors "Z" = Rock
calcStrategy _ _ = error "uknowm oponent move with strategy"
