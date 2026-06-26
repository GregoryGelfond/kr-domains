% Scenario 07: Layered DAG with before/2 and after/2 constraints.
% @expect sat
% @cost { 6 4 }
% @count optimal 1
% @optimal { start(s), included(a3,b3,1), included(b3,c3,1), included(c3,t,2), included(s,a3,2), end(t) }
%
% The variant-01 layered DAG with two ordering constraints. before(b3,t) forces
% the path through b3. after(c2,a2) is vacuous unless a2 is reached, and the
% optimizer avoids a2 (s -> a2 has weight 4 and a2 aids no feasible path), so the
% answer is dictated by before(b3,t) alone: s -> a3 -> b3 -> c3 -> t at weight 6.

#include "../../../encodings/shortest-path/variant-02.lp".

vertex(s).
vertex(a1).  vertex(a2).  vertex(a3).
vertex(b1).  vertex(b2).  vertex(b3).
vertex(c1).  vertex(c2).  vertex(c3).
vertex(t).

edge(s,a1,1). edge(s,a2,4). edge(s,a3,2).
edge(a1,b1,1). edge(a1,b2,3). edge(a1,b3,5).
edge(a2,b1,2). edge(a2,b2,1). edge(a2,b3,3).
edge(a3,b1,4). edge(a3,b2,2). edge(a3,b3,1).
edge(b1,c1,1). edge(b1,c2,3). edge(b1,c3,5).
edge(b2,c1,2). edge(b2,c2,1). edge(b2,c3,3).
edge(b3,c1,4). edge(b3,c2,2). edge(b3,c3,1).
edge(c1,t,1). edge(c2,t,3). edge(c3,t,2).

start(s).
end(t).

before(b3,t).
after(c2,a2).
