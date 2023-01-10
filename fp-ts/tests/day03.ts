import { pipe } from "fp-ts/lib/function";
import * as TE from "fp-ts/lib/TaskEither";
import * as E from "fp-ts/lib/Either";
import test from "ava";

import {
  solveSolvePartOne,
  solvePartOne,
  solvePartTwo,
  solveSolvePartTwo,
} from "../src/day03";

const exampleInput =
  "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw";

test("[day03] test example for part one", (t) =>
  t.deepEqual(solvePartOne(exampleInput), E.right(157)));

test("[day03] solve part one", async (t) => {
  await pipe(
    solveSolvePartOne(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 7817)
    )
  )();
});

test("[day03] test example for part two", (t) =>
  t.deepEqual(solvePartTwo(exampleInput), E.right(70)));

test("[day03] solve part two", async (t) => {
  await pipe(
    solveSolvePartTwo(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 2444)
    )
  )();
});
