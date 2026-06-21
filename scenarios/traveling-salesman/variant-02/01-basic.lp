% Scenario 01: Basic 2-salesman split on a 4-vertex graph.
% @expect sat
% @cost { 5 }
% @count optimal 2
%
% The graph splits into two cycles touching the start: a -> b -> a (cost 2) and
% a -> c -> d -> a (cost 3). Each salesman must return to the start, so the two
% cycles split across the two salesmen, for a total of 5, with two co-optimal
% assignments.

vertex(a). vertex(b). vertex(c). vertex(d).

edge(a,b,1). edge(b,a,1).
edge(a,c,1). edge(c,d,1). edge(d,a,1).

start(a).

salesman(s1). salesman(s2).
