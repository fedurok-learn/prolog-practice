parent(abraham, isaac). %% abraham is a parent of isaac
parent(isaac, jacob). %% isaac is a parent of jacob and so on
parent(john, jacob).
parent(victor, john).
parent(olga, loki).

%% common_descendant(+X:atom, +Y:atom, -D:atom) is semidet. 

common_descendant(X, Y, D) :- 
    X \== Y, common_descendant_(X, Y, D), !.

common_descendant_(X, Y, D) :- X = Y, D = X.

common_descendant_(X, Y, D) :- 
    X = Y,
    parent(X, XD), 
    parent(Y, YD),
    common_descendant(XD, YD, D).
