% Scenario 07: Layered DAG with combined ordering and a tighter cap.
% @expect sat
% @cost { 10 4 }
% @count optimal 1
% @optimal { start(s), included(a2,b3,3,2), included(b3,c3,1,5), included(c3,t,2,3), included(s,a2,4,1), end(t) }
%
% The scenario-06 graph with both layers tightened: before(b3,t) forces the path
% through b3; after(c1,a3) requires a3 (if visited) to reach c1; and
% maximum_cost(12) narrows the feasible b3-routes. The optimum is
% s -> a2 -> b3 -> c3 -> t at weight 10. This case pushes hardest on the
% interaction between the reachable_from/2 layer and the clingcon cost cap.

#include "../../../encodings/shortest-path/variant-04.lp".

vertex(s).
vertex(a1).  vertex(a2).  vertex(a3).
vertex(b1).  vertex(b2).  vertex(b3).
vertex(c1).  vertex(c2).  vertex(c3).
vertex(t).

edge(s,a1,1,5). edge(s,a2,4,1). edge(s,a3,2,3).
edge(a1,b1,1,5). edge(a1,b2,3,2). edge(a1,b3,5,1).
edge(a2,b1,2,3). edge(a2,b2,1,5). edge(a2,b3,3,2).
edge(a3,b1,4,1). edge(a3,b2,2,3). edge(a3,b3,1,5).
edge(b1,c1,1,5). edge(b1,c2,3,2). edge(b1,c3,5,1).
edge(b2,c1,2,3). edge(b2,c2,1,5). edge(b2,c3,3,2).
edge(b3,c1,4,1). edge(b3,c2,2,3). edge(b3,c3,1,5).
edge(c1,t,1,5). edge(c2,t,3,2). edge(c3,t,2,3).

start(s).
end(t).

before(b3,t).
after(c1,a3).

maximum_cost(12).
