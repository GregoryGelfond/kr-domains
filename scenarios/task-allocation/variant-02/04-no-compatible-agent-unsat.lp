% Scenario 04: Task with no compatible agent (UNSAT).
% @expect unsat
%
% t2 has no cost_of fact, though completion_time facts exist for it.
% compatible_with/2 is derived from cost_of/3 alone, so completion-time data does
% not make an agent compatible. The choice rule fails for t2, and the program is
% UNSAT, exactly as in variant-01.

task(t1). task(t2).
agent(a1). agent(a2). agent(a3).

cost_of(a1,t1,3). cost_of(a2,t1,5). cost_of(a3,t1,4).
% No cost_of for t2: t2 has no compatible agent.

completion_time(a1,t1,2). completion_time(a2,t1,1). completion_time(a3,t1,4).
completion_time(a1,t2,1). completion_time(a2,t2,1). completion_time(a3,t2,1).
