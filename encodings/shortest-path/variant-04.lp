% Resource-constrained shortest path with ordering.
%
% Minimize the total weight of a start-to-end path subject to a hard resource-
% cost cap and before/after ordering constraints, with the number of edges as a
% tie-breaker. Combines variant-02's ordering with variant-03's resource cap.
%
% Assumed inputs (supplied by a separate instance file):
%   vertex(V)        "V is a vertex."
%   edge(X,Y,W,C)    "an edge from X to Y with weight W and resource cost C."
%   start(V)         "V is the start vertex."
%   end(V)           "V is the end vertex."
%   before(X,Y)      "if Y is visited, X must be visited at some point before Y."
%   after(X,Y)       "if Y is visited, X must be visited at some point after Y."
%   maximum_cost(X)  "X is the largest resource cost a candidate path may have."

#defined vertex/1.
#defined edge/4.
#defined start/1.
#defined end/1.
#defined before/2.
#defined after/2.
#defined maximum_cost/1.

% Domain encoding

% included(X,Y,W,C): the edge from X to Y (weight W, resource cost C) lies on the
% candidate path. Any subset of edges may be included.
{ included(Src,Dst,W,C) : edge(Src,Dst,W,C) }.

% reachable_from(X,Y): Y is reachable from X along included edges (transitive).
reachable_from(Src,Dst) :-
    included(Src,Dst,_,_).

reachable_from(Src,Dst) :-
    vertex(Tmp),
    included(Src,Tmp,_,_),
    reachable_from(Tmp,Dst).

% reachable(V): V is reachable from the start.
reachable(Src) :-
    start(Src).

reachable(Dst) :-
    start(Src),
    reachable_from(Src,Dst).

% The end must be reachable from the start.
:- end(Src), not reachable(Src).

% No included edge may leave an unreachable vertex.
:- included(Src,_,_,_), not reachable(Src).

% Respect the ordering constraints.
:- before(X,Y), reachable(Y), not reachable_from(X,Y).
:- after(X,Y), reachable(Y), not reachable_from(Y,X).

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
