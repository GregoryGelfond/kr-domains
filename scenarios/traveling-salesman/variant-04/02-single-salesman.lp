% Scenario 02: Single salesman on a directed 4-cycle, loose windows.
% @expect sat
% @cost { 4 }
% @cautious optimal { traversed_by(a,b,1,s1), traversed_by(b,c,1,s1), traversed_by(c,d,1,s1), traversed_by(d,a,1,s1), depot(s1,a) }
%
% A one-way ring a -> b -> c -> d -> a, each edge cost 1 and time 1. The graph is
% directed, so the ordering is forced; the loose windows ([0,5]) all admit it.
% Total 4.

#include "../../../encodings/traveling-salesman/variant-04.lp".

vertex(a). vertex(b). vertex(c). vertex(d).

edge(a,b,1). edge(b,c,1). edge(c,d,1). edge(d,a,1).

edge_time(a,b,1). edge_time(b,c,1). edge_time(c,d,1). edge_time(d,a,1).

salesman(s1).
depot(s1,a).

time_window(b,0,5).
time_window(c,0,5).
time_window(d,0,5).
