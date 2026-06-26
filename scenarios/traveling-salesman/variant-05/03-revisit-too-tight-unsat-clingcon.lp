% Scenario 03: A revisit interval below the only feasible tour time (UNSAT). (clingcon)
% @expect unsat
% @elenctic solver clingcon
%
% The scenario-02 shape: single salesman, 3-cycle a -> b -> c -> a, tour_time 6.
% max_revisit_interval(b,4) requires tour_time <= 4, but no tour visits b in under
% 6 time units (a -> b is time 2, the return b -> c -> a is time 4). UNSAT.

#include "../../../encodings/traveling-salesman/variant-05-clingcon.lp".

vertex(a). vertex(b). vertex(c).

edge(a,b,1). edge(b,c,1). edge(c,a,1).

edge_time(a,b,2). edge_time(b,c,2). edge_time(c,a,2).

salesman(s1).
depot(s1,a).

max_revisit_interval(b,4).
