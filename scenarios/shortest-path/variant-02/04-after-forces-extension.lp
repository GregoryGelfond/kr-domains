% Scenario 04: An after/2 constraint forces an extra edge.
% @expect sat
% @cost { 3 3 }
% @count optimal 1
% @optimal { start(s), included(a,b,1), included(a,t,1), included(s,a,1), end(t) }
%
% Edges: s -> a (1), a -> t (1), a -> b (1, a dead-end branch). Unconstrained,
% the optimum is s -> a -> t at cost 2, with a -> b dropped by the tie-breaker.
% after(b,a) requires a to reach b, which forces a -> b in. s -> a and a -> t are
% still needed for end-reachability, so the optimum is the "Y" { s->a, a->t, a->b }
% at cost 3.

vertex(s).
vertex(a).
vertex(b).
vertex(t).

edge(s,a,1).
edge(a,t,1).
edge(a,b,1).

start(s).
end(t).

after(b,a).
