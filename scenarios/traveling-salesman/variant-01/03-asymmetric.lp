% Scenario 03: Asymmetric 4-vertex graph, traversal direction matters.
% @expect sat
% @cost { 4 }
% @count optimal 1
% @optimal { included(a,b,1), included(b,c,1), included(c,d,1), included(d,a,1), start(a) }
%
% The square's edges are cheap clockwise (cost 1) and expensive counter-clockwise
% (cost 10), with symmetric diagonals at cost 5. The clockwise tour
% a -> b -> c -> d -> a costs 4; the reverse costs 40, and any mixed tour takes an
% expensive edge or a diagonal and costs more.

#include "../../../encodings/traveling-salesman/variant-01.lp".

vertex(a). vertex(b). vertex(c). vertex(d).

% Cheap clockwise direction.
edge(a,b,1). edge(b,c,1). edge(c,d,1). edge(d,a,1).

% Expensive counter-clockwise direction.
edge(b,a,10). edge(c,b,10). edge(d,c,10). edge(a,d,10).

% Diagonals (symmetric).
edge(a,c,5). edge(c,a,5).
edge(b,d,5). edge(d,b,5).

start(a).
