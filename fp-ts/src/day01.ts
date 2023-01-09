import { pipe, flow } from "fp-ts/lib/function";
import * as RNA from "fp-ts/ReadonlyNonEmptyArray";
import * as S from "fp-ts/string";
import * as N from "fp-ts/number";
import * as E from "fp-ts/lib/Either";
import { getFileContent, stringToInt } from "./lib";
import * as TE from "fp-ts/lib/TaskEither";

type ParsedNumbers = RNA.ReadonlyNonEmptyArray<
  RNA.ReadonlyNonEmptyArray<number>
>;

export const solveSolvePartOne = () =>
  pipe(
    "../input/day01.txt",
    getFileContent,
    TE.chain(flow((x) => x.trim(), solvePartOne, TE.fromEither))
  );

export const solvePartOne = (lines: string) =>
  pipe(lines, parse, E.map(subSum), E.map(RNA.max(N.Ord)));

export const solveSolvePartTwo = () =>
  pipe(
    "../input/day01.txt",
    getFileContent,
    TE.chain(flow((x) => x.trim(), solvePartTwo, TE.fromEither))
  );

export const solvePartTwo = (lines: string) =>
  pipe(
    lines,
    parse,
    E.map(
      flow(subSum, RNA.sort(N.Ord), RNA.reverse, RNA.chunksOf(3), RNA.head, sum)
    )
  );

const parse = (lines: string) =>
  pipe(
    lines,
    S.split("\n\n"),
    // E.sequence = RNA<E> -> E<RNA>
    // E.traverse = sequence + map
    // E.traverseReadonlyNonEmptyArrayWithIndex = RNA<E> -> E<RNA>
    RNA.traverse(E.Applicative)(
      flow(S.split("\n"), RNA.traverse(E.Applicative)(stringToInt))
    )
  );

const sum = RNA.reduce(0, (a: number, b: number) => a + b);

const subSum = (numbers: ParsedNumbers): RNA.ReadonlyNonEmptyArray<number> =>
  pipe(numbers, RNA.map(sum));
