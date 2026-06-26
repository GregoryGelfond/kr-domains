% Resource-constrained shortest path.
%
% Minimize the total weight of a start-to-end path subject to a hard cap on
% its total resource cost, with the number of edges as a tie-breaker.
%
% Assumed inputs (supplied by a separate instance file):
%   vertex(V)        "V is a vertex."
%   edge(X,Y,W,C)    "an edge from X to Y with weight W and resource cost C."
%   start(V)         "V is the start vertex."
%   end(V)           "V is the end vertex."
%   maximum_cost(X)  "X is the largest resource cost a candidate path may have."

#defined vertex/1.
#defined edge/4.
#defined start/1.
#defined end/1.
#defined maximum_cost/1.

% Domain encoding

% included(X,Y,W,C): the edge from X to Y (weight W, resource cost C) lies on
% the candidate path. Any subset of edges may be included.
{ included(Src,Dst,W,C) : edge(Src,Dst,W,C) }.

% reachable(V): V is reachable from the start along included edges.
reachable(Src) :-
    start(Src).

reachable(Dst) :-
    reachable(Src),
    included(Src,Dst,_,_),
    vertex(Src),
    vertex(Dst).

% The end must be reachable from the start.
:- end(Src), not reachable(Src).

% No included edge may leave an unreachable vertex.
:- included(Src,_,_,_), not reachable(Src).

% weight(X): X is the total weight of the included edges.
weight(X) :- X = #sum{ W,Src,Dst,C : included(Src,Dst,W,C) }.

% cost(X): X is the total resource cost of the included edges.
cost(X) :- X = #sum{ C,Src,Dst,W : included(Src,Dst,W,C) }.

% A candidate path's cost may not exceed the maximum.
:- C > M, cost(C), maximum_cost(M).

% Solver directives

% Minimize weight; break ties on the number of included edges.
#minimize{ W@2 : weight(W) }.
#minimize{ 1@1,Src,Dst,W,C : included(Src,Dst,W,C) }.

#show included/4.
#show start/1.
#show end/1.
