import { pipe, flow } from "fp-ts/lib/function";
import * as E from "fp-ts/lib/Either";
import * as S from "fp-ts/lib/string";
import * as RNA from "fp-ts/lib/ReadonlyNonEmptyArray";
import * as TE from "fp-ts/lib/TaskEither";
import { match } from "ts-pattern";
import { getFileContent, RNAsum } from "./lib";

export const enum RPS {
  Rock = 1,
  Paper = 2,
  Scissors = 3,
}

export const enum GameState {
  Win = 6,
  Draw = 3,
  Lose = 0,
}

export const solveSolvePartOne = () =>
  pipe(
    "../input/day02.txt",
    getFileContent,
    TE.chain(flow((x) => x.trim(), solvePartOne, TE.fromEither))
  );

export const solveSolvePartTwo = () =>
  pipe(
    "../input/day02.txt",
    getFileContent,
    TE.chain(flow((x) => x.trim(), solvePartTwo, TE.fromEither))
  );

export const solvePartOne = (lines: string) =>
  pipe(lines, parse, E.map(flow(RNA.map(calcGameScore), RNAsum)));

export const solvePartTwo = (lines: string): E.Either<string, number> =>
  pipe(lines, parseV2, E.map(flow(RNA.map(calcGameScore), RNAsum)));

const parse = (lines: string) =>
  pipe(lines, S.split("\n"), RNA.traverse(E.Applicative)(parseGame));

const parseV2 = (lines: string) =>
  pipe(lines, S.split("\n"), RNA.traverse(E.Applicative)(parseGameV2));

const parseGame = (raw: string) =>
  pipe(
    raw,
    S.split(" "),
    RNA.traverse(E.Applicative)(parseRPS),
    E.map((x) => [x[0], x[1]] as [RPS, RPS])
  );

const parseGameV2 = (raw: string) =>
  pipe(
    E.Do,
    E.let("split", () => pipe(raw, S.split(" "))), // let for pure
    E.bind("opponent_play", ({ split }) => pipe(split, RNA.head, parseRPS)),
    E.bind("strategy", ({ split }) => pipe(split, RNA.last, parseGameStrategy)),
    E.map(({ opponent_play, strategy }) => [strategy, opponent_play] as const),
    E.chain(chooseRPS)
  );

const parseRPS = (symbol: string) =>
  match(symbol)
    .with("A", "X", () => E.right(RPS.Rock))
    .with("B", "Y", () => E.right(RPS.Paper))
    .with("C", "Z", () => E.right(RPS.Scissors))
    .otherwise(() => E.left(`Error in parsing ${symbol}`));

const parseGameStrategy = (symbol: string) =>
  match(symbol)
    .with("X", () => E.right(GameState.Lose))
    .with("Y", () => E.right(GameState.Draw))
    .with("Z", () => E.right(GameState.Win))
    .otherwise(() => E.left("error in parsing strategy"));

export const calcGameState = (game: [RPS, RPS]) =>
  match(game)
    .with([RPS.Rock, RPS.Paper], () => GameState.Win)
    .with([RPS.Paper, RPS.Scissors], () => GameState.Win)
    .with([RPS.Scissors, RPS.Rock], () => GameState.Win)
    .when(
      (game) => game[0] === game[1],
      () => GameState.Draw
    )
    .otherwise(() => GameState.Lose);

export const calcGameScore = (game: [RPS, RPS]) =>
  game[1].valueOf() + calcGameState(game).valueOf();

const chooseRPS = (x: readonly [GameState, RPS]) =>
  pipe(
    match(x)
      .when(
        (x) => x[0] == GameState.Draw,
        () => [x[1], x[1]]
      )
      // Rock
      .with([GameState.Lose, RPS.Rock], () => [RPS.Rock, RPS.Scissors])
      .with([GameState.Win, RPS.Rock], () => [RPS.Rock, RPS.Paper])
      // Paper
      .with([GameState.Lose, RPS.Paper], () => [RPS.Paper, RPS.Rock])
      .with([GameState.Win, RPS.Paper], () => [RPS.Paper, RPS.Scissors])
      //Scissors
      .with([GameState.Lose, RPS.Scissors], () => [RPS.Scissors, RPS.Paper])
      .with([GameState.Win, RPS.Scissors], () => [RPS.Scissors, RPS.Rock])
      .otherwise(() => null),
    E.fromNullable("unknown error with strategy selection"),
    E.map((x) => [x[0], x[1]] as [RPS, RPS])
  );
