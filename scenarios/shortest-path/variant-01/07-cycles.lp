% Scenario 07: Graph with cycles.
% @expect sat
% @cost { 3 3 }
% @count optimal 1
% @optimal { start(s), included(d,e,1), included(e,t,1), included(s,d,1), end(t) }
%
% Two s-to-t routes plus back-edges that form cycles among reachable vertices.
% A back-edge raises cost without aiding reachability, so cost minimization takes
% the cheaper cycle-free route, s -> d -> e -> t at weight 3, and leaves every
% back-edge out.

vertex(s).
vertex(a). vertex(b). vertex(c).
vertex(d). vertex(e).
vertex(t).

% Forward chain (weight 4 total)
edge(s,a,1). edge(a,b,1). edge(b,c,1). edge(c,t,1).

% Cheaper alternate route (weight 3 total)
edge(s,d,1). edge(d,e,1). edge(e,t,1).

% Back-edges, each forming a cycle among reachable vertices.
edge(b,a,1). edge(c,b,1). edge(e,d,1). edge(t,c,1).

start(s).
end(t).
