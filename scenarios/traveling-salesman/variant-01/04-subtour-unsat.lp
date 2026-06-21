% Scenario 04: Two disjoint 2-cycles, ruled out by reachability (UNSAT).
% @expect unsat
%
% The graph has exactly two cycles, a <-> b and c <-> d. Including all four edges
% satisfies the in/out-degree constraints (one in, one out per vertex), but the
% result is two disjoint 2-cycles, not one tour. Reachability catches it: from a,
% only b is reachable, so c and d fail :- vertex(V), not reachable(V), and the
% program is UNSAT. This is the canonical subtour-elimination case the variant-01
% reachability rule handles.

vertex(a). vertex(b). vertex(c). vertex(d).

% Cycle 1: a <-> b.
edge(a,b,1). edge(b,a,1).

% Cycle 2: c <-> d. Disconnected from cycle 1.
edge(c,d,1). edge(d,c,1).

start(a).
