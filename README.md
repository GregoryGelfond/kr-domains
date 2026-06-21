# kr-domains

A literate corpus of Answer Set Programming domain encodings: pure-clingo baselines paired with
clingcon constraint (CP) variants, where every documented expectation is a machine-checked
`@`-contract run by [elenctic](https://github.com/GregoryGelfond/elenctic).

The corpus serves two purposes. It is a reference of worked encodings of classic combinatorial
problems, written to be read; and it is **elenctic's client #1**, dogfooding the contract format.
`pixi run test` solves all 117 cases across both solvers and verifies each against its contract.

## Layout

Two trees, discovered together:

- **`encodings/<domain>/`** holds the reusable problem encodings. A baseline `variant-NN.lp` (pure
  ASP, run by clingo) may be paired with a `variant-NN-clingcon.lp` twin that moves the numeric
  layer into clingcon's CP backend.
- **`scenarios/<domain>/[variant-NN/]NN-<desc>.lp`** holds the problem instances (facts), each
  carrying the `@`-contract that says what the solver must return.

A scenario pairs with its encoding by directory:
`scenarios/shortest-path/variant-03/03-budget-forces-detour.lp` runs against
`encodings/shortest-path/variant-03.lp` (and its `-clingcon` twin, when one exists). A
**self-contained** domain (`send-money`, `n-queens`) carries the contract in the encoding header and
has no separate scenarios.

## The `@`-contract

Each contract-bearing file opens with a doc-comment: a one-line summary, the contract as `@`-tagged
lines, then the prose rationale.

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
```

The tags assert satisfiability (`@expect`), the optimal cost vector (`@cost`), the number of optimal
models (`@count optimal`), a full model (`@optimal` / `@model`), a forced backbone
(`@cautious optimal`), a CSP assignment (`@assign`), and free-prose caveats (`@note`). The format and
its semantics are elenctic's; see [elenctic](https://github.com/GregoryGelfond/elenctic) for the full
grammar.

## Domains

| Domain | Encodings | Cases | What it is |
|---|---|---|---|
| `shortest-path` | 4 variants (+2 clingcon) | 42 | minimum-cost path; before/after ordering; a resource-cost cap |
| `task-allocation` | 4 variants (+1 clingcon) | 25 | minimum-cost agent assignment; makespan; task groups; scheduling |
| `traveling-salesman` | 5 variants (+2 clingcon) | 35 | single and multi-salesman, multi-depot, time windows, surveillance |
| `equality-generalized-tsp` | 2 encodings | 6 | one-in-a-set TSP (visit exactly one vertex per subset) |
| `send-money` | 2 self-contained | 2 | the SEND + MORE = MONEY cryptarithm |
| `n-queens` | 7 self-contained | 7 | 8-queens: a naive-to-optimized refinement ladder, plus a clingcon CP model |

This list is expected to grow as further domains and variants are added.

The **n-queens** ladder shows what the contracts buy: six progressively-optimized ASP encodings and
one clingcon CP model, each carrying `@count 92`, so the suite certifies that every optimization step
preserves the 92-solution set.

## Running

Everything runs in the pinned `pixi` environment (clingo 5.8, clingcon 5.2.1, Python 3.14).

```sh
pixi install                  # resolve the toolchain + elenctic (first run)

pixi run test                 # the whole corpus through elenctic under pytest (117 cases)
pixi run check                # ruff + mypy --strict + the test suite (the full gate)
pixi run python -m corpus     # list every discovered case (encoding, instance, solver)
```

To run the corpus through elenctic's own CLI:

```sh
pixi run -- elenctic encodings scenarios            # solve and check every case
pixi run -- elenctic encodings scenarios --explain  # the derived run plan, without solving
```

To inspect a single case's answer sets directly against the solver, run its encoding and scenario
together:

```sh
pixi run -- clingo   --opt-mode=opt \
  encodings/shortest-path/variant-03.lp \
  scenarios/shortest-path/variant-03/03-budget-forces-detour.lp

pixi run -- clingcon --opt-mode=opt \
  encodings/shortest-path/variant-03-clingcon.lp \
  scenarios/shortest-path/variant-03/03-budget-forces-detour.lp
```

A self-contained encoding runs on its own: `pixi run -- clingo encodings/send-money/send-money.lp`.

## License

MIT. Copyright (c) 2026 Gregory Gelfond. See [LICENSE](LICENSE).
