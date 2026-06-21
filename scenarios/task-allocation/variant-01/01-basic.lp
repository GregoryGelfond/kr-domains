% Scenario 01: Basic 2-task, 2-agent assignment.
% @expect sat
% @cost { 5 }
% @count optimal 1
% @optimal { assigned_to(a1,t1), assigned_to(a2,t2), cost_of(a1,t1,3), cost_of(a2,t2,2) }
%
% Both agents can take both tasks. The cheapest agent per task is a1 for t1
% (cost 3) and a2 for t2 (cost 2), for a total of 5.

task(t1).
task(t2).

agent(a1).
agent(a2).

cost_of(a1,t1,3).
cost_of(a2,t1,5).
cost_of(a1,t2,4).
cost_of(a2,t2,2).
