% Scenario 05: Three competing routes.
% @expect sat
% @cost { 3 3 }
% @count optimal 1
% @optimal { start(s), included(b,c,1), included(c,t,1), included(s,b,1), end(t) }
%
% Three routes from s to t:
%   s -> t            cost 10
%   s -> a -> t       cost 4 + 4 = 8
%   s -> b -> c -> t  cost 1 + 1 + 1 = 3   (cheapest)
% Cost minimization takes the longest-hop route because it is cheapest; the
% edge-count tie-breaker does not override the cost objective.

vertex(s).
vertex(a).
vertex(b).
vertex(c).
vertex(t).

edge(s,t,10).
edge(s,a,4).
edge(a,t,4).
edge(s,b,1).
edge(b,c,1).
edge(c,t,1).

start(s).
end(t).
