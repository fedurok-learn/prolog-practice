%% fib(+N:int, -R:int) is semidet.
fib(N, R) :-  fib(1, 1, N, R).

%% fib(+N1:int, +N2:int, +N:int, -R:int) is semidet.
fib(N1, _N2, N, R) :- N = 1, R = N1, !.

fib(N1, N2, N, R) :- 
    NewN1 is N2,
    NewN2 is N1 + N2,
    NewN is N - 1,
    fib(NewN1, NewN2, NewN, R).
