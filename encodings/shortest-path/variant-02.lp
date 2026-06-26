% Shortest path with ordering constraints.
%
% Minimize the total cost of a start-to-end path subject to before/after
% ordering constraints, with the number of edges as a tie-breaker.
%
% Assumed inputs (supplied by a separate instance file):
%   vertex(V)     "V is a vertex."
%   edge(X,Y,C)   "an edge from X to Y with cost C."
%   start(V)      "V is the start vertex."
%   end(V)        "V is the end vertex."
%   before(X,Y)   "if Y is visited, X must be visited at some point before Y."
%   after(X,Y)    "if Y is visited, X must be visited at some point after Y."

#defined vertex/1.
#defined edge/3.
#defined start/1.
#defined end/1.
#defined before/2.
#defined after/2.

% Domain encoding

% included(X,Y,C): the edge from X to Y (cost C) lies on the candidate path. Any
% subset of edges may be included.
{ included(Src,Dst,C) : edge(Src,Dst,C) }.

% reachable_from(X,Y): Y is reachable from X along included edges (transitive).
reachable_from(Src,Dst) :-
    included(Src,Dst,_).

reachable_from(Src,Dst) :-
    vertex(Tmp),
    included(Src,Tmp,_),
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
:- included(Src,_,_), not reachable(Src).

% Respect the ordering constraints.
:- before(X,Y), reachable(Y), not reachable_from(X,Y).
:- after(X,Y), reachable(Y), not reachable_from(Y,X).

% cost(X): X is the total cost of the included edges.
cost(X) :- X = #sum{ C,Src,Dst : included(Src,Dst,C) }.

% Solver directives

% Minimize cost; break ties on the number of included edges.
#minimize{ C@2 : cost(C) }.
#minimize{ 1@1,Src,Dst,C : included(Src,Dst,C) }.

#show included/3.
#show start/1.
#show end/1.
