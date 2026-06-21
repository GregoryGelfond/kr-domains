% Scenario 02: Single salesman degenerates to classical TSP.
% @expect sat
% @cost { 3 }
% @count optimal 1
% @optimal { traversed_by(a,b,1,s1), traversed_by(b,c,1,s1), traversed_by(c,a,1,s1), start(a) }
%
% With one salesman, variant-02 reduces to variant-01: a single Hamiltonian tour.
% The variant-01 triangle, cheap forward cycle (3) against expensive reverse (15).

vertex(a). vertex(b). vertex(c).

edge(a,b,1). edge(b,c,1). edge(c,a,1).
edge(a,c,5). edge(c,b,5). edge(b,a,5).

start(a).

salesman(s1).
