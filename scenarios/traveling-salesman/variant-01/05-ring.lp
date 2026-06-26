% Scenario 05: 5-vertex ring with diagonal shortcuts.
% @expect sat
% @cost { 5 }
% @count optimal 2
%
% A ring a-b-c-d-e-a with both directions at cost 1, plus full diagonals at cost
% 5. The cheap Hamiltonian cycle is the ring itself, cost 5 (five unit edges); any
% tour taking a diagonal swaps a cost-5 edge for two cost-1 edges and so must add
% a unit edge elsewhere, exceeding 5. The two ring directions are co-optimal.

#include "../../../encodings/traveling-salesman/variant-01.lp".

vertex(a). vertex(b). vertex(c). vertex(d). vertex(e).

% Ring edges (both directions, cost 1).
edge(a,b,1). edge(b,a,1).
edge(b,c,1). edge(c,b,1).
edge(c,d,1). edge(d,c,1).
edge(d,e,1). edge(e,d,1).
edge(e,a,1). edge(a,e,1).

% Diagonal shortcuts (both directions, cost 5).
edge(a,c,5). edge(c,a,5).
edge(a,d,5). edge(d,a,5).
edge(b,d,5). edge(d,b,5).
edge(b,e,5). edge(e,b,5).
edge(c,e,5). edge(e,c,5).

start(a).
