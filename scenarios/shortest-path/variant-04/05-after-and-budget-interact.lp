% Scenario 05: after/2 and the cap jointly select a non-default path.
% @expect sat
% @cost { 6 2 }
% @count optimal 1
% @optimal { start(s), included(a,t,3,1), included(s,a,3,1), end(t) }
%
% Three routes from s to t (weight, cost):
%   s -> t       weight 1, cost 100   (least weight, over budget)
%   s -> a -> t  weight 6, cost 2
%   s -> b -> t  weight 4, cost 2
% maximum_cost(5) rules out the direct edge. Of the rest, s -> b -> t is lighter
% (weight 4), but after(a,s) requires s to reach a, which s -> b -> t does not, so
% the cheapest ordering-feasible route is s -> a -> t at weight 6.

vertex(s).
vertex(a).
vertex(b).
vertex(t).

edge(s,t,1,100).
edge(s,a,3,1).
edge(a,t,3,1).
edge(s,b,2,1).
edge(b,t,2,1).

start(s).
end(t).

after(a,s).

maximum_cost(5).
