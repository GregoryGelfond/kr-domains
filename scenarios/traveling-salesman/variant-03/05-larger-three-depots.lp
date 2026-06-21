% Scenario 05: Three depots, two customers each, natural clusters.
% @expect sat
% @cost { 9 }
% @count optimal 1
% @optimal { traversed_by(a,d1,1,s1), traversed_by(b,e1,1,s2), traversed_by(c,f1,1,s3), traversed_by(d1,d2,1,s1), traversed_by(d2,a,1,s1), traversed_by(e1,e2,1,s2), traversed_by(e2,b,1,s2), traversed_by(f1,f2,1,s3), traversed_by(f2,c,1,s3), depot(s1,a), depot(s2,b), depot(s3,c) }
%
% Nine vertices in three 3-cycles, one per depot: a -> d1 -> d2 -> a,
% b -> e1 -> e2 -> b, c -> f1 -> f2 -> c, each cost 3. No cross-cluster edges, so
% each salesman patrols its own cluster, visiting both its customers. Total 9.

vertex(a). vertex(b). vertex(c).
vertex(d1). vertex(d2).
vertex(e1). vertex(e2).
vertex(f1). vertex(f2).

% Cluster a -> d1 -> d2 -> a.
edge(a,d1,1). edge(d1,d2,1). edge(d2,a,1).

% Cluster b -> e1 -> e2 -> b.
edge(b,e1,1). edge(e1,e2,1). edge(e2,b,1).

% Cluster c -> f1 -> f2 -> c.
edge(c,f1,1). edge(f1,f2,1). edge(f2,c,1).

salesman(s1). salesman(s2). salesman(s3).
depot(s1,a). depot(s2,b). depot(s3,c).
