% Scenario 02: Seven vertices, three subsets, cheap vs expensive layers.
% @expect sat
% @cost { 4 }
% @optimal { included(a1,b1,1), included(b1,c1,1), included(c1,s,1), included(s,a1,1), visited(a1), visited(b1), visited(c1), visited(s), start(s) }
%
% Vertices s (start) and three subsets, each with a cheap representative (a1, b1,
% c1) and an expensive one (a2, b2, c2). Cross-arcs between the layers carry a
% penalty, so no partially-cheap tour beats the all-cheap one. The optimum takes
% s -> a1 -> b1 -> c1 -> s at cost 4; the all-expensive tour costs 12.

#include "../../encodings/equality-generalized-tsp/egtsp.lp".

vertex(s).
vertex(a1). vertex(a2).
vertex(b1). vertex(b2).
vertex(c1). vertex(c2).

% Cheap path: s -> a1 -> b1 -> c1 -> s
edge(s,a1,1).  edge(a1,b1,1).  edge(b1,c1,1).  edge(c1,s,1).

% Expensive path: s -> a2 -> b2 -> c2 -> s
edge(s,a2,3).  edge(a2,b2,3).  edge(b2,c2,3).  edge(c2,s,3).

% Cross-arcs between cheap and expensive layers (penalty cost 5)
edge(a1,b2,5). edge(a2,b1,5).
edge(b1,c2,5). edge(b2,c1,5).

start(s).

in_subset(a1,1). in_subset(a2,1).
in_subset(b1,2). in_subset(b2,2).
in_subset(c1,3). in_subset(c2,3).
