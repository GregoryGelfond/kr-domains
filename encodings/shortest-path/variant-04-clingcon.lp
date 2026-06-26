% Resource-constrained shortest path with ordering (clingcon variant).
%
% Same problem as the baseline variant-04.lp: minimize the total weight of a
% start-to-end path under a hard resource-cost cap and before/after ordering
% constraints, with edge count as a tie-breaker.
%
% The clingo/clingcon split mirrors variant-03-clingcon: the whole Boolean/
% Datalog layer (edge choice, reachability, the reachable_from/2 transitive
% closure, end-reachability, the no-dangling-edge and ordering constraints,
% weight aggregation, the lexicographic minimize) stays in ASP; only the
% resource-cost cap moves into clingcon as a &sum constraint over an ASP/CSP-
% bridged 0/1 shadow x(Src,Dst,W,C), where the CP backend propagates the bound
% during search and prunes partial assignments that already exceed the budget.
% The minimize stays in ASP because clingcon's &minimize has no priority
% mechanism that composes with #minimize.

% Inputs (same as the baseline)

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

% No vertex should be reachable without being included.
:- included(Src,_,_,_), not reachable(Src).

% Respect the ordering constraints.
:- before(X,Y), reachable(Y), not reachable_from(X,Y).
:- after(X,Y), reachable(Y), not reachable_from(Y,X).

% ASP/CSP bridge

% A 0/1 CSP shadow per edge.
&dom { 0..1 } = x(Src,Dst,W,C) :- edge(Src,Dst,W,C).

% Force x(...) to mirror the truth of included(...).
:- included(Src,Dst,W,C), &sum { x(Src,Dst,W,C) } = 0.

:- edge(Src,Dst,W,C),
   not included(Src,Dst,W,C),
   &sum { x(Src,Dst,W,C) } = 1.

% Hard linear constraint (clingcon)

% Resource-cost cap. The CP backend propagates this bound during search,
% pruning partial assignments that already overflow the budget.
&sum { C*x(Src,Dst,W,C) : edge(Src,Dst,W,C) } <= M :- maximum_cost(M).

% Optimization (ASP)

weight(W) :- W = #sum { Wt,Src,Dst,Ct : included(Src,Dst,Wt,Ct) }.

#minimize { W@2 : weight(W) }.
#minimize { 1@1,Src,Dst,W,C : included(Src,Dst,W,C) }.

#show included/4.
#show start/1.
#show end/1.
