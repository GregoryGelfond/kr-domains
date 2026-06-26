% Scenario 01: Two salesmen, two depots, one customer each.
% @expect sat
% @cost { 4 }
% @count optimal 1
% @optimal { traversed_by(a,c,1,s1), traversed_by(b,d,1,s2), traversed_by(c,a,1,s1), traversed_by(d,b,1,s2), depot(s1,a), depot(s2,b) }
%
% Two disjoint 2-cycles, one per depot-customer pair: s1 at depot a serves c
% (a -> c -> a, cost 2), s2 at depot b serves d (b -> d -> b, cost 2). No
% cross-cluster edges, so each salesman is confined to its own pair. Total 4.

#include "../../../encodings/traveling-salesman/variant-03.lp".

vertex(a). vertex(b). vertex(c). vertex(d).

edge(a,c,1). edge(c,a,1).
edge(b,d,1). edge(d,b,1).

salesman(s1). salesman(s2).
depot(s1,a). depot(s2,b).
