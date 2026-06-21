% Scenario 02: Makespan tie-break among cost-tied solutions.
% @expect sat
% @cost { 3 5 }
% @count optimal 3
%
% Every agent-task cost is 1, so all assignments tie at cost 3 and the makespan
% breaks the tie. With completion times of 5 on a1 and 2 on a2 for each task:
%   all three on a1:     makespan max(15, 0) = 15
%   two on a1, one a2:   makespan max(10, 2) = 10
%   one on a1, two a2:   makespan max( 5, 4) = 5   (optimum)
%   all three on a2:     makespan max( 0, 6) = 6
% The three "one-on-a1, two-on-a2" assignments tie at makespan 5.

task(t1). task(t2). task(t3).
agent(a1). agent(a2).

cost_of(a1,t1,1). cost_of(a2,t1,1).
cost_of(a1,t2,1). cost_of(a2,t2,1).
cost_of(a1,t3,1). cost_of(a2,t3,1).

completion_time(a1,t1,5). completion_time(a2,t1,2).
completion_time(a1,t2,5). completion_time(a2,t2,2).
completion_time(a1,t3,5). completion_time(a2,t3,2).
