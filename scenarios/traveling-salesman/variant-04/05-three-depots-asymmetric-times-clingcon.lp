% Scenario 05: Three depots, one customer each, asymmetric edge times and windows. (clingcon)
% @expect sat
% @cost { 6 }
% @note  clingcon leaves the CSP visit-times free, so the optimal class is intractable to enumerate; only the optimal cost is asserted here
% @elenctic solver clingcon
%
% Three disjoint 2-cycles, one per depot-customer pair, with asymmetric out- and
% back-times so a customer's visit time depends on the traversal direction. Each
% window admits the natural tour:
%   s1: a, p. a -> p time 2, p -> a time 1. visit p at 2 in [0,3]; tour_time 3.
%   s2: b, q. b -> q time 1, q -> b time 3. visit q at 1 in [0,2]; tour_time 4.
%   s3: c, r. c -> r time 3, r -> c time 2. visit r at 3 in [0,4]; tour_time 5.
% No cross-cluster edges, so each salesman patrols its own pair. Total cost 6 (six
% unit edges).

#include "../../../encodings/traveling-salesman/variant-04-clingcon.lp".

vertex(a). vertex(b). vertex(c).
vertex(p). vertex(q). vertex(r).

edge(a,p,1). edge(p,a,1).
edge(b,q,1). edge(q,b,1).
edge(c,r,1). edge(r,c,1).

edge_time(a,p,2). edge_time(p,a,1).
edge_time(b,q,1). edge_time(q,b,3).
edge_time(c,r,3). edge_time(r,c,2).

salesman(s1). salesman(s2). salesman(s3).
depot(s1,a). depot(s2,b). depot(s3,c).

time_window(p,0,3).
time_window(q,0,2).
time_window(r,0,4).
