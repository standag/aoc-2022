import { pipe } from "fp-ts/lib/function";
import * as O from "fp-ts/lib/Option";
import * as S from "fp-ts/lib/string";
import * as RA from "fp-ts/lib/ReadonlyArray";
import * as RNA from "fp-ts/lib/ReadonlyNonEmptyArray";
import * as E from "fp-ts/lib/Either";
import * as TE from "fp-ts/lib/TaskEither";
import { getFileContentV2, getLetterIndex, RNAsum } from "./lib";

export const solveSolvePartOne = () =>
  pipe("../input/day03.txt", getFileContentV2, TE.chainEitherKW(solvePartOne));

export const solveSolvePartTwo = () =>
  pipe("../input/day03.txt", getFileContentV2, TE.chainEitherKW(solvePartTwo));

export const solvePartOne = (lines: string) =>
  pipe(
    lines,
    S.split("\n"),
    RNA.traverse(E.Applicative)(ruckSackScore),
    E.map(RNAsum)
  );

export const solvePartTwo = (lines: string) =>
  pipe(
    lines,
    S.split("\n"),
    RNA.chunksOf(3),
    RNA.traverse(E.Applicative)(groupBadgeScore),
    E.map(RNAsum)
  );

const halve = (rucksack: string) =>
  pipe(
    rucksack,
    S.size,
    (size) => Math.round(size / 2),
    (halveSize) => pipe(rucksack, S.split(""), RNA.splitAt(halveSize))
  );

const itemScore = (item: string) =>
  pipe(
    item,
    getLetterIndex,
    O.map((x) => x + 1),
    E.fromOption(() => "unknown item in rucksack" as const)
  );

const ruckSackScore = (items: string) =>
  pipe(
    items,
    halve,
    (h) => RA.intersection(S.Eq)(h[0])(h[1]),
    RA.head,
    E.fromOption(() => "no common item in rucksack" as const),
    E.chainW(itemScore)
  );

const findCommon = (
  groupRuckSacks: readonly RNA.ReadonlyNonEmptyArray<string>[]
) =>
  pipe(
    groupRuckSacks[0],
    RA.intersection(S.Eq)(groupRuckSacks[1]),
    RA.intersection(S.Eq)(groupRuckSacks[2]),
    RA.head
  );

const groupBadgeScore = (groupRuckSacks: readonly string[]) =>
  pipe(
    groupRuckSacks,
    RA.map(S.split("")),
    findCommon,
    E.fromOption(() => "no common item in group rucksacks" as const),
    E.chainW(itemScore)
  );
