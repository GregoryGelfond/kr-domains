% Scenario 02: Fully-connected 4-vertex graph, symmetric costs.
% @expect sat
% @cost { 8 }
% @count optimal 2
%
% Six undirected edges (each as two directed edges of equal cost): a-b 1, a-c 3,
% a-d 4, b-c 2, b-d 5, c-d 1. The three Hamiltonian cycles cost:
%   a-b-c-d-a  1 + 2 + 1 + 4 = 8   (optimum)
%   a-b-d-c-a  1 + 5 + 1 + 3 = 10
%   a-c-b-d-a  3 + 2 + 5 + 4 = 14
% The optimum cycle is co-optimal in its two traversal directions.

vertex(a). vertex(b). vertex(c). vertex(d).

edge(a,b,1). edge(b,a,1).
edge(a,c,3). edge(c,a,3).
edge(a,d,4). edge(d,a,4).
edge(b,c,2). edge(c,b,2).
edge(b,d,5). edge(d,b,5).
edge(c,d,1). edge(d,c,1).

start(a).
