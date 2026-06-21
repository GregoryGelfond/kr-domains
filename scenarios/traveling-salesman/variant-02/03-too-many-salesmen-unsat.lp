% Scenario 03: Two salesmen, only one Hamiltonian cycle (UNSAT).
% @expect unsat
%
% The graph has exactly one tour through the start, a -> b -> c -> a. A second
% salesman would need a disjoint tour (none exists) or would share a vertex with
% the first (forbidden by the one-salesman-per-non-start-vertex constraint), and a
% salesman that traverses nothing fails returns-to-start. So the program is UNSAT.

vertex(a). vertex(b). vertex(c).

edge(a,b,1). edge(b,c,1). edge(c,a,1).

start(a).

salesman(s1). salesman(s2).
