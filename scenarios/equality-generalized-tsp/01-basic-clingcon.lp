% Scenario 01: Five vertices, two subsets, a clear cheapest representative each. (clingcon)
% @expect sat
% @cost { 3 }
% @optimal { included(a,c,1), included(c,s,1), included(s,a,1), visited(a), visited(c), visited(s), start(s) }
% @elenctic solver clingcon
%
% Vertices s (start), a and b (subset 1), c and d (subset 2). Cheap arcs run
% s -> a -> c -> s; the alternatives are uniformly expensive. The optimum picks a
% and c, taking s -> a -> c -> s at cost 3.

#include "../../encodings/equality-generalized-tsp/egtsp-clingcon.lp".

vertex(s). vertex(a). vertex(b). vertex(c). vertex(d).

edge(s,a,1). edge(s,b,5).
edge(a,c,1). edge(a,d,5).
edge(b,c,5). edge(b,d,5).
edge(c,s,1). edge(d,s,5).

start(s).

in_subset(a,1). in_subset(b,1).
in_subset(c,2). in_subset(d,2).
