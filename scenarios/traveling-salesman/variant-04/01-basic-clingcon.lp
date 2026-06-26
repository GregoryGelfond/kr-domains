% Scenario 01: Two depots, one customer each, with edge times and windows. (clingcon)
% @expect sat
% @cost { 4 }
% @cautious optimal { traversed_by(a,c,1,s1), traversed_by(b,d,1,s2), traversed_by(c,a,1,s1), traversed_by(d,b,1,s2), depot(s1,a), depot(s2,b) }
% @elenctic solver clingcon
%
% The variant-03 two-cluster shape plus the variant-04 timing layer: s1 runs
% a -> c -> a, s2 runs b -> d -> b (each cost 2, time 2). Each customer's window
% admits its tour (c visited at time 1, d at time 1, both in [0,3]); the depots
% have no window, so the close times are free. Total 4.

#include "../../../encodings/traveling-salesman/variant-04-clingcon.lp".

vertex(a). vertex(b). vertex(c). vertex(d).

edge(a,c,1). edge(c,a,1).
edge(b,d,1). edge(d,b,1).

edge_time(a,c,1). edge_time(c,a,1).
edge_time(b,d,1). edge_time(d,b,1).

salesman(s1). salesman(s2).
depot(s1,a). depot(s2,b).

time_window(c,0,3).
time_window(d,0,3).
