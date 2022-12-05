module Day05 (solvePartOne, solvePartTwo) where

import Data.List (elemIndex)

inputFile :: IO String
inputFile = readFile "input/day05.txt"

-- |
-- Solve part one.
--
-- >>> solvePartOne
-- "GRTSWNJHH"
solvePartOne :: IO String
solvePartOne = solvePartOne' <$> inputFile

-- |
-- Pure solution for part one.
--
-- >>> solvePartOne' "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1"
-- "DCP"
-- >>> solvePartOne' "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
-- "CMZ"
solvePartOne' :: String -> String
solvePartOne' input = map last $ foldl (flip move) layout moves
  where
    (layout, moves) = parse input

-- |
-- Solve part two.
--
-- >>> solvePartTwo
solvePartTwo :: IO String
solvePartTwo = solvePartTwo' <$> inputFile

-- |
-- Pure solution for part two.
--
-- >>> solvePartTwo' "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2"
-- "MCD"
solvePartTwo' :: String -> String
solvePartTwo' input = map last $ foldl (flip moveMultiple) layout moves
  where
    (layout, moves) = parse input

-----------------------------------------------------------------------------------

unwrap :: Maybe a -> a
unwrap (Just x) = x
unwrap Nothing = error "unwrap nothing"

push :: a -> [a] -> [a]
push a = foldr (:) [a]

pop :: [Char] -> (Char, [Char])
pop [] = (' ', [])
pop xs = (last xs, init xs)

peek :: [Char] -> Char
peek [] = ' '
peek (x : _) = x

-----------------------------------------------------------------------------------

parse :: String -> ([[Char]], [(Int, Int, Int)])
parse input = do
  let (layout, moves) = splitAt (unwrap $ elemIndex "" $ lines input) $ lines input
  (parseLayout layout, parseMoves moves)

parseLayout' :: Int -> [[Char]] -> [Char]
parseLayout' i l = reverse $ map (!! ii) $ init l
  where
    ii = (1 : [5, 9 ..]) !! i

parseLayout :: [String] -> [[Char]]
parseLayout layout = map (filter (/= ' ') . (`parseLayout'` layout)) [0 .. size]
  where
    size = (read (last $ words $ last layout) :: Int) - 1

toNumber :: Int -> [String] -> Int
toNumber i s = read (s !! i) :: Int

-- |
-- parse one line with move instructions (from,to) - 1, indexed from 0
--
-- >>> parseMove "move 1 from 2 to 1"
-- (1,1,0)
parseMove :: String -> (Int, Int, Int)
parseMove "" = (0, 0, 0)
parseMove line = (toNumber 1 moveInstruction, toNumber 3 moveInstruction - 1, toNumber 5 moveInstruction - 1)
  where
    moveInstruction = words line

parseMoves :: [String] -> [(Int, Int, Int)]
parseMoves = map parseMove

replace :: Int -> [Char] -> [[Char]] -> [[Char]]
replace n q qs = do
  let (x, _ : ys) = splitAt n qs
  push q x ++ ys

move' :: Int -> Int -> [[Char]] -> [[Char]]
move' from to q = replace from one $ replace to two q
  where
    (item, one) = pop $ q !! from
    two = push item $ q !! to

-- |
-- follow move instruction
--
-- >>> move (1,1,0) ["ZN", "MCD", "P"]
-- ["ZND","MC","P"]
-- >>> move (3,0,2) ["ZND", "CM", "P"]
-- ["","CM","PDNZ"]
move :: (Int, Int, Int) -> [[Char]] -> [[Char]]
move (0, _, _) q = q
move (n, from, to) q = move (n - 1, from, to) $ move' from to q

moveMultiple :: (Int, Int, Int) -> [[Char]] -> [[Char]]
moveMultiple (n, from, to) q = replace from one $ replace to two q
  where
    toRemove = q !! from
    (one, removed) = splitAt (length toRemove - n) toRemove
    two = (q !! to) ++ removed
