"""The kr-domains corpus layout — the single value that points elenctic at this corpus.

elenctic (the library) discovers and runs the corpus from this ``Layout``; this module is the only
corpus-specific configuration. Run it directly to inspect the discovered cases — a thin driver over
elenctic's ``discover``, composed from it, not a reimplementation (library-first).
"""

from pathlib import Path

from elenctic import Layout, discover

__all__ = ["LAYOUT"]

_ROOT = Path(__file__).parent

LAYOUT = Layout(encodings_root=_ROOT / "encodings", cases_root=_ROOT / "scenarios")


def _main() -> None:
    """List every discovered case (encoding, instance, solver) — the corpus's shape at a glance."""
    for case in discover(LAYOUT):
        instance = case.instance.name if case.instance is not None else "(self-contained)"
        print(f"{case.contract_source.relative_to(_ROOT)} [{case.solver}] {instance}")


if __name__ == "__main__":
    _main()
