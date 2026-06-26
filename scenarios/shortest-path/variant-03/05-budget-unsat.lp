% Scenario 05: No path fits under the budget cap (UNSAT).
% @expect unsat
%
% The only s-to-t walks are:
%   s -> t            cost 10
%   s -> a -> t       cost 3 + 3 = 6
%   s -> b -> c -> t  cost 2 + 2 + 2 = 6
% maximum_cost(5) rules out every complete path. A strict prefix is infeasible
% too: either the end is unreachable, or an included edge leaves an unreachable
% vertex. So the program is UNSAT.

#include "../../../encodings/shortest-path/variant-03.lp".

vertex(s).
vertex(a).
vertex(b).
vertex(c).
vertex(t).

edge(s,t,1,10).
edge(s,a,1,3).
edge(a,t,1,3).
edge(s,b,1,2).
edge(b,c,1,2).
edge(c,t,1,2).

start(s).
end(t).

maximum_cost(5).
