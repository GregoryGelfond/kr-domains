% Scenario 03: Zero-cost detour from a reachable vertex.
% @expect sat
% @cost { 2 2 }
% @count optimal 1
% @optimal { start(a), included(a,b,1), included(b,c,1), end(c) }
%
% The path a -> b -> c costs 2. A zero-cost edge c -> d branches off the end:
% both { a->b, b->c } and { a->b, b->c, c->d } reach c at cost 2, so only the
% edge-count tie-breaker rules out the detour.

vertex(a).
vertex(b).
vertex(c).
vertex(d).

edge(a,b,1).
edge(b,c,1).
edge(c,d,0).

start(a).
end(c).
