import { pipe, flow } from "fp-ts/lib/function";
import * as TE from "fp-ts/lib/TaskEither";
import * as E from "fp-ts/lib/Either";
import * as RA from "fp-ts/lib/ReadonlyArray";
import fs from "fs";
import { promisify } from "util";

const readFromFile = promisify(fs.readFile);

export const getFileContent = (path: string) =>
  TE.tryCatch(
    () => readFromFile(path, "utf-8"),
    () => "error: problem with file"
  );

export const getFileContentV2 = (path: string) =>
  pipe(
    TE.tryCatch(
      () => readFromFile(path, "utf-8"),
      () => "error: problem with file" as const
    ),
    TE.map((content) => content.trim())
  );

export const stringToInt = (n: string) =>
  pipe(
    parseInt(n),
    E.fromPredicate(
      (x) => !isNaN(x),
      () => `error: cannot parse ${n}`
    )
  );

export const RNAsum = RA.reduce(0, (a: number, b: number) => a + b);

const small_letters = RA.makeBy(26, (i: number) =>
  String.fromCharCode("a".charCodeAt(0) + i)
);
const big_letters = RA.makeBy(26, (i: number) =>
  String.fromCharCode("A".charCodeAt(0) + i)
);
const letters = RA.concat(big_letters)(small_letters);

export const getLetterIndex = (letter: string) =>
  pipe(
    letters,
    RA.findIndex((l) => l === letter)
  );
