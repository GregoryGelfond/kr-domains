"""Run the kr-domains corpus through elenctic under pytest: a driver composed from the library.

Each discovered case is one parametrized test: solve it, fold the per-check reports to a verdict,
and assert PASS. elenctic's three-valued verdict maps onto three distinct pytest outcomes:

- PASS      → the test passes;
- FAIL      → an assertion failure carrying the rendered diagnostic (the program decided wrong);
- UNDECIDED → an xfail carrying the diagnostic: a budget-cut solve is "could not decide," kept
  distinct from a wrong answer (elenctic §7a), never a silent green and never a red FAIL.

A HarnessError (an elenctic bug, never a verdict) propagates as a loud test error with its own
traceback, distinct from a contract FAIL.
"""

import pytest
from elenctic import Case, Verdict, case_verdict, discover, render, run_case

from corpus import LAYOUT

_CASES: tuple[Case, ...] = discover(LAYOUT)


def _case_id(case: Case) -> str:
    """A readable, stable test id: the contract's corpus-relative path plus the solver."""
    return f"{case.contract_source.relative_to(LAYOUT.cases_root.parent)} — {case.solver}"


@pytest.mark.parametrize("case", _CASES, ids=_case_id)
def test_corpus(case: Case) -> None:
    reports = run_case(case)  # a HarnessError (elenctic bug) propagates as a test error
    verdict = case_verdict(reports)
    if verdict is Verdict.UNDECIDED:
        pytest.xfail(render(case, reports))  # could-not-decide ≠ decided-wrong (§7a)
    assert verdict is Verdict.PASS, render(case, reports)
