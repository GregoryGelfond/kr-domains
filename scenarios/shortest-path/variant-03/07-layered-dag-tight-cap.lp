% Scenario 07: Layered DAG with a tight resource-cost cap.
% @expect sat
% @cost { 12 4 }
% @count optimal 4
%
% The scenario-06 graph with the cap tightened to maximum_cost(10), ruling out
% 06's near-minimum-weight paths and forcing a heavier route. Under clingcon the
% &sum <= 10 bound propagates during search, pruning much of the candidate space
% early.

#include "../../../encodings/shortest-path/variant-03.lp".

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

maximum_cost(10).
