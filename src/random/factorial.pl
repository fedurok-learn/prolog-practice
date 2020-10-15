%% factorial(+N:int, -R:int) is semidet
factorial(N, R) :- factorial(N, 1, R).

%% factorial(+N:int, +Acc:int, -R:int) is semidet
factorial(0, R, R) :- !.

factorial(N, Acc, R) :- 
    NewN is N - 1,
    NewAcc is Acc * N,
    factorial(NewN, NewAcc, R).
