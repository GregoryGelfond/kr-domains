% Scenario 03: A subset's only vertex has no incoming edge (UNSAT).
% @expect unsat
%
% Vertices s (start), a (subset 1), b (subset 2). Return arcs a -> s and b -> s
% exist, but nothing reaches b. Subset 2 forces b onto the tour, yet b has no
% incoming tour edge, so the program is UNSAT.

vertex(s). vertex(a). vertex(b).

edge(s,a,1).
edge(a,s,1).
edge(b,s,1).

start(s).

in_subset(a,1).
in_subset(b,2).
