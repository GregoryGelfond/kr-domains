% Scenario 03: A customer's window is unreachable on any tour (UNSAT).
% @expect unsat
%
% Single salesman, depot a, customers b and c on a one-way 3-cycle
% a -> b -> c -> a with each edge time 2. The only tour visits c at time 4, but
% time_window(c,0,2) requires it by time 2. No tour satisfies both the
% every-vertex-visited requirement and the window.

vertex(a). vertex(b). vertex(c).

edge(a,b,1). edge(b,c,1). edge(c,a,1).

edge_time(a,b,2). edge_time(b,c,2). edge_time(c,a,2).

salesman(s1).
depot(s1,a).

time_window(c,0,2).
