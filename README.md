# kr-domains

A literate corpus of Answer Set Programming domain encodings: pure-clingo baselines paired with
clingcon constraint (CP) variants, where every documented expectation is a machine-checked
`@`-contract run by [elenctic](https://github.com/GregoryGelfond/elenctic).

The corpus serves two purposes. It is a reference of worked encodings of classic combinatorial
problems, written to be read; and it is **elenctic's client #1**, dogfooding the contract format.
`pixi run test` solves all 118 cases across both solvers and verifies each against its contract.

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
models (`@count optimal`), a full model (`@optimal` / `@model`), a forced backbone
(`@cautious optimal`), a CSP assignment (`@assign`), and free-prose caveats (`@note`). The format and
its semantics are elenctic's; see [elenctic](https://github.com/GregoryGelfond/elenctic) for the full
grammar.

## Domains

**Open encodings** (`encodings/` + `scenarios/`):

| Domain | Variants | Cases | What it is |
|---|---|---|---|
| `shortest-path` | 4 (+2 clingcon) | 42 | minimum-cost path; before/after ordering; a resource-cost cap |
| `task-allocation` | 4 (+1 clingcon) | 25 | minimum-cost agent assignment; makespan; task groups; scheduling |
| `traveling-salesman` | 5 (+2 clingcon) | 35 | single and multi-salesman, multi-depot, time windows, surveillance |
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

## Running with elenctic

[elenctic](https://github.com/GregoryGelfond/elenctic) is the test runner. Point it at the corpus,
or at any subtree, and it discovers every contract-bearing `.lp`, solves it under its declared
solver, and checks it against its `@`-contract. There is no separate harness to maintain: the corpus
is plain `.lp`, and elenctic runs it. Everything runs in the pinned `pixi` environment (clingo 5.8,
clingcon 5.2.1); `pixi install` resolves the toolchain and elenctic on first run.

```sh
pixi run test                                        # the whole corpus (118 cases): elenctic .
pixi run -- elenctic scenarios                       # the instance scenarios (108 cases)
pixi run -- elenctic scenarios/shortest-path         # one domain's scenarios
pixi run -- elenctic scenarios/shortest-path/variant-03/01-basic.lp   # a single case
pixi run -- elenctic . --explain                     # the run plan per case, without solving
```

A non-`PASS` prints a rendered diagnostic: `FAIL` (the program decided wrong), kept distinct from
`UNDECIDED` (a budget-cut solve). The exit status is `0` (all pass), `1` (some `FAIL`/`UNDECIDED`),
or `2` (a corpus or harness error).

Each case `#include`s its encoding, so a case also runs directly on its solver:

```sh
pixi run -- clingo   --opt-mode=opt scenarios/shortest-path/variant-03/03-budget-forces-detour.lp
pixi run -- clingcon --opt-mode=opt scenarios/shortest-path/variant-03/03-budget-forces-detour-clingcon.lp
```

A standalone program runs on its own: `pixi run -- clingo standalone/send-money/send-money.lp`.

## License

MIT. Copyright (c) 2026 Gregory Gelfond. See [LICENSE](LICENSE).
