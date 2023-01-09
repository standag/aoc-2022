import { pipe } from "fp-ts/function";
import * as E from "fp-ts/Either";
import * as TE from "fp-ts/TaskEither";
import {
  solvePartOne,
  solvePartTwo,
  solveSolvePartOne,
  solveSolvePartTwo,
} from "../src/day01";

import test from "ava";

test("[day01] test example for part one", (t) => {
  t.deepEqual(
    solvePartOne(
      "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
    ),
    E.right(24000)
  );
});

test("[day01] solve part one", async (t) => {
  await pipe(
    solveSolvePartOne(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 68467)
    )
  )();
});

test("[day01] test example for part two", (t) => {
  t.deepEqual(
    solvePartTwo(
      "1000\n2000\n3000\n\n4000\n\n5000\n6000\n\n7000\n8000\n9000\n\n10000"
    ),
    E.right(45000)
  );
});

test("[day01] solve part two", async (t) => {
  await pipe(
    solveSolvePartTwo(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 203420)
    )
  )();
});
