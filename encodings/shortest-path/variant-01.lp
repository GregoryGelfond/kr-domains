% Shortest path.
%
% Minimize the total cost of a start-to-end path, with the number of edges as a
% tie-breaker.
%
% Assumed inputs (supplied by a separate instance file):
%   vertex(V)     "V is a vertex."
%   edge(X,Y,C)   "an edge from X to Y with cost C."
%   start(V)      "V is the start vertex."
%   end(V)        "V is the end vertex."

#defined vertex/1.
#defined edge/3.
#defined start/1.
#defined end/1.

% Domain encoding

% included(X,Y,C): the edge from X to Y (cost C) lies on the candidate path. Any
% subset of edges may be included.
{ included(Src,Dst,C) : edge(Src,Dst,C) }.

% reachable(V): V is reachable from the start along included edges.
reachable(Src) :-
    start(Src).
reachable(Dst) :-
    reachable(Src), included(Src,Dst,_),
    vertex(Src), vertex(Dst).

% The end must be reachable from the start.
:- end(Src), not reachable(Src).

% No included edge may leave an unreachable vertex.
:- included(Src,_,_), not reachable(Src).

% cost(X): X is the total cost of the included edges.
cost(X) :- X = #sum{ C,Src,Dst : included(Src,Dst,C) }.

% Solver directives

% Minimize cost; break ties on the number of included edges.
#minimize{ C@2 : cost(C) }.
#minimize{ 1@1,Src,Dst,C : included(Src,Dst,C) }.

#show included/3.
#show start/1.
#show end/1.
