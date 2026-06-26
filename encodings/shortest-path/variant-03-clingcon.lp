% Resource-constrained shortest path (clingcon variant).
%
% Same problem as the baseline variant-03.lp: minimize the total weight of a
% start-to-end path under a hard resource-cost cap, with edge count as a
% tie-breaker.
%
% The clingo/clingcon split: the Boolean/Datalog part (edge choice,
% reachability, the no-dangling-edge constraints, weight aggregation, the
% lexicographic minimize) stays in ASP; only the resource-cost cap moves into
% clingcon as a &sum constraint, where the CP backend propagates the bound
% during search and prunes partial assignments that already exceed the budget.
% The minimize stays in ASP because clingcon's &minimize has no priority
% mechanism that composes with #minimize.
%
% clingcon does not auto-link an ASP atom to a same-named CSP variable, so an
% explicit 0/1 CSP shadow x(Src,Dst,W,C) per edge is bridged to included/4 by
% two integrity constraints. The bridge adds a little grounding overhead, and
% it is what lets the &sum reflect the actual ASP choices.

% Inputs (same as the baseline)

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

% No vertex can be reached from the start if it is not included.
:- included(Src,_,_,_), not reachable(Src).

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

% Weight aggregation and the lexicographic minimize stay in ASP (clingcon's
% &minimize has no priority mechanism).
weight(W) :- W = #sum { Wt,Src,Dst,Ct : included(Src,Dst,Wt,Ct) }.

#minimize { W@2 : weight(W) }.
#minimize { 1@1,Src,Dst,W,C : included(Src,Dst,W,C) }.

#show included/4.
#show start/1.
#show end/1.
