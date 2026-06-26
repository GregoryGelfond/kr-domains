% Scenario 02: A precedence constraint orders the tasks in time. (clingcon)
% @expect sat
% @cost { 2 }
% @cautious optimal { assigned_to(a1,t1), assigned_to(a2,t2), cost_of(a1,t1,1), cost_of(a2,t2,1) }
% @elenctic solver clingcon
%
% The scenario-01 agents and costs, plus before(t1,t2): t1 must finish before t2
% starts. The tasks go to different agents, so this is purely a timing constraint.
% Cost-min is unchanged at 2; the schedule places t1's end at or before t2's start.

#include "../../../encodings/task-allocation/variant-04-clingcon.lp".

task(t1). task(t2).
agent(a1). agent(a2).

cost_of(a1,t1,1). cost_of(a2,t1,3).
cost_of(a1,t2,3). cost_of(a2,t2,1).

completion_time(a1,t1,2). completion_time(a2,t1,2).
completion_time(a1,t2,2). completion_time(a2,t2,2).

time_window(t1,0,5).
time_window(t2,0,5).

before(t1,t2).
