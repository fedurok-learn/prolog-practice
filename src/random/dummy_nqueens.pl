%% very dummy and useless n-queens implementation

notintersect([]).
notintersect([[HX, HY]|T]) :- 
    maplist(notintersect2([HX, HY]), T), 
    notintersect(T).

notintersect2(C1, C2) :- \+ intersect2(C1, C2).
intersect2([X1, Y1], [X2, Y2]) :- X1 = X2 ; Y1 = Y2.
intersect2([X1, Y1], [X2, Y2]) :- 
    D1 is X1 - Y1, D2 is X2 - Y2,
    abs(D1, R), abs(D2, R).

factorial(N, R) :- 
    ( 
    	N = 0 -> R = 1 ; 
    	NewN is N - 1, 
    	factorial(NewN, NewR), 
    	R is N * NewR 
    ).

nqueens(N, R) :- 
    findall(_, nqueens(N, N, [], _), L), 
    length(L, LR),
    factorial(N, F),
    R is LR / F.

nqueens(0, _Max, L, L).
nqueens(N, Max, L, R) :- 
    between(1, Max, X),
    between(1, Max, Y),
    NewL = [[X, Y]|L],
    NewN is N - 1,
    notintersect(NewL),
    nqueens(NewN, Max, NewL, R).
