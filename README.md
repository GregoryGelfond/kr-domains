# kr-domains

A literate corpus of Answer Set Programming domain encodings: pure-clingo baselines paired with
clingcon constraint (CP) variants. The files are plain `.lp`, run directly with clingo or clingcon.
The cases were checked with clingo 5.8.3 and clingcon 5.2.1.

The corpus is a reference of worked encodings of classic combinatorial problems, written to be
read. Each documented expectation is an `@`-contract that
[elenctic](https://github.com/GregoryGelfond/elenctic) can check; installing it is optional.

## Layout

Three trees, discovered together. The split is by *authored form* (open vs. closed):

- **`encodings/<domain>/`** holds the reusable **open** encodings: a problem schema with `#defined`
  inputs and no contract of its own. A baseline `variant-NN.lp` (pure ASP, run by clingo) may be
  paired with a `variant-NN-clingcon.lp` twin that moves the numeric layer into clingcon's CP backend.
- **`scenarios/<domain>/[variant-NN/]NN-<desc>.lp`** holds the problem instances (facts) that
  complete an encoding, each carrying the `@`-contract that says what the solver must return.
- **`standalone/<problem>/`** holds the **closed** programs: the instance is baked in, the contract
  rides in the file header, and the program runs on its own with no separate scenario (`n-queens`,
  `send-money`, `task-scheduling`).

Placement follows that line: a problem ships **standalone** when it carries one fixed instance and
its contract inline, and as an **encoding + scenarios** pair when one reusable schema is exercised
across many instances. (n-queens ships standalone at a fixed N = 8, though it could be posed as a
schema over N.)

A scenario builds on its encoding with an `#include`:
`scenarios/shortest-path/variant-03/03-budget-forces-detour.lp` includes
`encodings/shortest-path/variant-03.lp`. When an encoding has a `-clingcon` twin, each instance gets
a sibling scenario (`…-clingcon.lp`) that includes the twin and declares `% @elenctic solver
clingcon`: two distinct programs of the same problem, each with its own contract; the pure-ASP cases
declare nothing and default to clingo.

## The `@`-contract

Each contract-bearing file opens with a doc-comment: a one-line summary, the contract as `@`-tagged
lines, then the prose rationale. An instance scenario then `#include`s its encoding and lists the
instance facts; a standalone program follows the contract with the encoding itself.

```
% Scenario 03: Budget cap forces a higher-weight path.
% @expect sat
% @cost { 4 2 }
% @count optimal 1
% @optimal { start(s), included(a,t,2,1), included(s,a,2,1), end(t) }
%
% Two routes run from s to t:
%   s -> t       weight 1, cost 10  (least weight, but over budget)
%   s -> a -> t  weight 4, cost 2
% maximum_cost(5) rules out the direct edge ...

#include "../../../encodings/shortest-path/variant-03.lp".

vertex(s). vertex(a). vertex(t).
edge(s,t,1,10). edge(s,a,2,1). edge(a,t,2,1).
start(s). end(t). maximum_cost(5).
```

The tags assert satisfiability (`@expect`), the optimal cost vector (`@cost`), the number of optimal
models (`@count optimal`), a full answer set (`@optimal` / `@answer-set`), a forced backbone
(`@cautious optimal`), a CSP assignment (`@assign`), and free-prose caveats (`@note`). The format and
its semantics are elenctic's; see [elenctic](https://github.com/GregoryGelfond/elenctic) for the full
grammar.

## Domains

**Open encodings** (`encodings/` + `scenarios/`):

| Domain | Variants | Cases | What it is |
|---|---|---|---|
| `shortest-path` | 4 (+2 clingcon) | 53 | minimum-cost path; before/after ordering; a resource-cost cap |
| `task-allocation` | 4 (+1 clingcon) | 25 | minimum-cost agent assignment; makespan; task groups; scheduling |
| `traveling-salesman` | 5 (+2 clingcon) | 41 | single and multi-salesman, multi-depot, time windows, surveillance |
| `equality-generalized-tsp` | 2 | 6 | one-in-a-set TSP (visit exactly one vertex per subset) |

**Standalone** (`standalone/`, closed programs):

| Problem | Programs | Cases | What it is |
|---|---|---|---|
| `n-queens` | 7 | 7 | 8-queens: a naive-to-optimized refinement ladder, plus a clingcon CP model |
| `send-money` | 2 | 2 | the SEND + MORE = MONEY cryptarithm |
| `task-scheduling` | 1 (clingcon) | 1 | minimum-cost scheduling with a co-optimal timeline; the worked example of the clingcon theory-witness contracts (assign-optimal and the joint where-witness) |

This list is expected to grow as further domains and variants are added.

The **n-queens** ladder shows what the contracts buy: six progressively-optimized ASP encodings and
one clingcon CP model, each carrying `@count 92`, so the suite certifies that every optimization step
preserves the 92-solution set.

## Running a case

Each case `#include`s its encoding, so a case runs directly on its solver:

```sh
clingo   --opt-mode=opt scenarios/shortest-path/variant-03/03-budget-forces-detour.lp
clingcon --opt-mode=opt scenarios/shortest-path/variant-03/03-budget-forces-detour-clingcon.lp
```

A standalone program runs on its own: `clingo standalone/send-money/send-money.lp`.

## Checking contracts with elenctic

The `@` tags are [elenctic](https://github.com/GregoryGelfond/elenctic) contracts. To verify them,
install elenctic however you like and point it at the corpus: it discovers every contract-bearing
`.lp`, solves it under its declared solver, and checks it against its `@`-contract.

```sh
elenctic .                                              # the whole corpus (135 cases)
elenctic --root . scenarios                             # the instance scenarios (125 cases)
elenctic --root . scenarios/shortest-path               # one domain's scenarios (53 cases)
elenctic --root . scenarios/shortest-path/variant-03/01-basic.lp   # a single case
```

elenctic refuses an `#include` that leaves the run's root, which defaults to the directory it is
pointed at. A scenario includes `../../../encodings/...`, so a subset of `scenarios/` names the
repository root with `--root .`; `standalone/` needs no root.

A non-`PASS` prints a rendered diagnostic: `FAIL` (the program decided wrong), kept distinct from
`UNDECIDED` (a search cut short by `--max-seconds` or `--max-answer-sets`). The exit status is `0`
(every claim holds), `1` (some `FAIL` or `UNDECIDED`), `2` (a case could not be checked) or `3`
(elenctic itself failed).

## Versioning

Tags are dated — `v2026.08.01` — because what varies here is how current the corpus is, not what it
promises to a caller. A corpus exports no API, so the compatibility that `MAJOR.MINOR.PATCH` exists
to communicate has nothing to attach to: adding a domain or correcting a contract cannot break
anyone's build. A date says the one thing a reader of a corpus wants to know.

Each tag records the solver versions the cases were checked against. The corpus and those solvers
move independently, so neither one's version is derived from the other's.

## License

MIT. Copyright (c) 2026 Gregory Gelfond. See [LICENSE](LICENSE).
