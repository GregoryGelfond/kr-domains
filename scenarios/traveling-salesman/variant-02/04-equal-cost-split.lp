% Scenario 04: Two equal 2-cycles at the start, either salesman takes either.
% @expect sat
% @cost { 4 }
% @count optimal 2
%
% Two disjoint 2-cycles through the start, a <-> b and a <-> c, each cost 2. The
% two salesmen split the cycles for a total of 4; the assignment is symmetric, so
% two co-optimal models exist.

vertex(a). vertex(b). vertex(c).

edge(a,b,1). edge(b,a,1).
edge(a,c,1). edge(c,a,1).

start(a).

salesman(s1). salesman(s2).
