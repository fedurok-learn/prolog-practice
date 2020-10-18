parent(abraham, isaac). %% abraham is a parent of isaac
parent(isaac, jacob). %% isaac is a parent of jacob and so on
parent(john, jacob).
parent(victor, john).
parent(olga, loki).

%% desc(-X:atom, -D:atom) is nondet.
desc(X, D) :- parent(X, D).
desc(X, D) :- parent(X, XD), desc(XD, D).

%% common_descendant(-X:atom, -Y:atom, -D:atom) is nondet.
common_descendant(X, Y, CD) :- desc(X, CD), desc(Y, CD).
