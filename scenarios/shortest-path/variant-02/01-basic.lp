% Scenario 01: Basic shortest path, no ordering constraints.
% @expect sat
% @cost { 2 2 }
% @count optimal 1
% @optimal { start(a), included(a,b,1), included(b,c,1), end(c) }
%
% The variant-01 triangle. With no before/after facts, variant-02 reduces to
% variant-01: the direct edge a -> c (cost 3) loses to a -> b -> c (cost 2).

#include "../../../encodings/shortest-path/variant-02.lp".

vertex(a).
vertex(b).
vertex(c).

edge(a,b,1).
edge(b,c,1).
edge(a,c,3).

start(a).
end(c).
