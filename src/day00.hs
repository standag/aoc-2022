module Day00 (solve_part_one, solve_part_two) where

-- |
-- Solve part one.
--
-- >>> solve_part_one
-- "1 2 3 4\n"
solve_part_one :: IO String
solve_part_one = readFile "input/day00.txt"

-- |
-- Solve part two.
--
-- >>> solve_part_two
-- 10
solve_part_two :: IO Int
solve_part_two = sum <$> (map (\x -> read x :: Int) <$> (words <$> (solve_part_one)))
-- solve_part_two = do
--                   content <- readFile "input/day00.txt"
--                   let x1 = words $ content
--                   let x2 = map (\x -> read x :: Int) x1
--                   let x3 = sum x2
--                   return x3
