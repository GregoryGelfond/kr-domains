% Scenario 01: Basic shortest path on a triangle.
% @expect sat
% @cost { 2 2 }
% @count optimal 1
% @optimal { start(a), included(a,b,1), included(b,c,1), end(c) }
%
% The direct edge a -> c costs 3; the two-hop path a -> b -> c costs 2, so the
% two-hop path is shortest.

vertex(a).
vertex(b).
vertex(c).

edge(a,b,1).
edge(b,c,1).
edge(a,c,3).

start(a).
end(c).
