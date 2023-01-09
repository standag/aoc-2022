import { pipe } from "fp-ts/lib/function";
import * as TE from "fp-ts/lib/TaskEither";
import * as E from "fp-ts/lib/Either";
import fs from "fs";
import { promisify } from "util";

const readFromFile = promisify(fs.readFile);

export const getFileContent = (path: string) =>
  TE.tryCatch(
    () => readFromFile(path, "utf-8"),
    () => "error: problem with file"
  );

export const stringToInt = (n: string) =>
  pipe(
    parseInt(n),
    E.fromPredicate(
      (x) => !isNaN(x),
      () => `error: cannot parse ${n}`
    )
  );
