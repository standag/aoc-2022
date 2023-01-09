import { pipe } from "fp-ts/lib/function";
import * as TE from "fp-ts/lib/TaskEither";
import * as E from "fp-ts/lib/Either";
import test from "ava";

import {
  calcGameScore,
  RPS,
  GameState,
  calcGameState,
  solveSolvePartOne,
  solvePartOne,
  solvePartTwo,
  solveSolvePartTwo,
} from "../src/day02";

test("[day02] test game state calculation", (t) => {
  t.is(calcGameState([RPS.Rock, RPS.Paper]), GameState.Win);
  t.is(calcGameState([RPS.Paper, RPS.Scissors]), GameState.Win);
  t.is(calcGameState([RPS.Paper, RPS.Paper]), GameState.Draw);
  t.is(calcGameState([RPS.Paper, RPS.Rock]), GameState.Lose);
});

test("[day02] test score calculation", (t) => {
  t.is(calcGameScore([RPS.Rock, RPS.Paper]), 8);
  t.is(calcGameScore([RPS.Paper, RPS.Rock]), 1);
  t.is(calcGameScore([RPS.Scissors, RPS.Scissors]), 6);
});

test("[day02] test example for part one", (t) => {
  t.deepEqual(solvePartOne("A Y\nB X\nC Z"), E.right(15));
});

test("[day02] solve part one", async (t) => {
  await pipe(
    solveSolvePartOne(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 14531)
    )
  )();
});

test("[day02] test example for part two", (t) => {
  t.deepEqual(solvePartTwo("A Y\nB X\nC Z"), E.right(12));
});

test("[day02] solve part two", async (t) => {
  await pipe(
    solveSolvePartTwo(),
    TE.match(
      (err) => t.fail(err),
      (result) => t.is(result, 11258)
    )
  )();
});
