% Scenario 04: No path from start to end (UNSAT).
% @expect unsat
%
% Two disconnected components, { a, b } and { c, d }. With start = a and end = d,
% no walk from a to d exists, so no included subset makes d reachable: the
% constraint :- end(Src), not reachable(Src) fires.

vertex(a).
vertex(b).
vertex(c).
vertex(d).

edge(a,b,1).
edge(c,d,1).

start(a).
end(d).
