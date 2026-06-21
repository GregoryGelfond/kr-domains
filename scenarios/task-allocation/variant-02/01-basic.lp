% Scenario 01: Basic assignment with completion times.
% @expect sat
% @cost { 5 2 }
% @count optimal 1
% @optimal { assigned_to(a1,t1), assigned_to(a2,t2), cost_of(a1,t1,3), cost_of(a2,t2,2) }
%
% variant-02 inherits variant-01's cost-minimum; completion_time/3 matters only
% as the makespan tie-break when costs tie. Here cost-min is unique: t1 -> a1 (3),
% t2 -> a2 (2), total 5, with makespan max(2, 1) = 2.

task(t1). task(t2).
agent(a1). agent(a2).

cost_of(a1,t1,3). cost_of(a2,t1,5).
cost_of(a1,t2,4). cost_of(a2,t2,2).

completion_time(a1,t1,2). completion_time(a2,t1,3).
completion_time(a1,t2,4). completion_time(a2,t2,1).
