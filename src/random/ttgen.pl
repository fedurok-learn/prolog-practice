%% operators
:- op(1000,xfy,'and').
:- op(1000,xfy,'or').
:- op(900,fy,'not').

%% and their truth tables(tt)
boole_and(0,0,0).
boole_and(0,1,0).
boole_and(1,0,0).      
boole_and(1,1,1).

boole_or(0,0,0).      
boole_or(0,1,1).      
boole_or(1,0,1).
boole_or(1,1,1).

boole_not(0,1).
boole_not(1,0).

%% vector of N zeros
initial([], []).
initial([_|XT], [0|T]) :- initial(XT, T).

%% add one to binary number in a form of a list L
successor(L, R) :- 
    reverse(L, RL),
    successor_reversed(RL, SRL),
    reverse(SRL, R).
successor_reversed([0|T], [1|T]).
successor_reversed([1|T], [0|RT]) :- successor_reversed(T, RT).

%% get set of variables from expression
varset(Expr, R) :- varlist(Expr, L), list_to_set(L, R).

varlist(X, R) :- atom(X), R = [X].
varlist(not X, R) :- varlist(X, R).
varlist(X or Y, R) :- varlist(X and Y, R).
varlist(X and Y, R) :- varlist(X, RX), varlist(Y, RY), append(RX, RY, R).

%% generate a concrete result from a concrete variable values
substitute(X, Vars, Vals, R) :- atom(X), lookup(X, Vars, Vals, R).
substitute(not X, Vars, Vals, R) :- 
    substitute(X, Vars, Vals, RX), boole_not(RX, R).
substitute(X and Y, Vars, Vals, R) :- 
    substitute(X, Vars, Vals, RX), substitute(Y, Vars, Vals, RY),
    boole_and(RX, RY, R).
substitute(X or Y, Vars, Vals, R) :- 
    substitute(X, Vars, Vals, RX), substitute(Y, Vars, Vals, RY),
    boole_or(RX, RY, R).
    
lookup(X, Keys, Vals, R) :- nth0(XI, Keys, X), nth0(XI, Vals, R).

%% finally generate table
truth_table(Expr, [Vars, [Vals,R]|T]) :-
    varset(Expr, Vars),
    initial(Vars, Vals),
    substitute(Expr, Vars, Vals, R),
    successor(Vals, SVals),
    tt_loop(Expr, Vars, SVals, T).

tt_loop(Expr, Vars, Vals, [[Vals, HR]|T]) :- 
    substitute(Expr, Vars, Vals, HR),
    ( successor(Vals, SVals) -> tt_loop(Expr, Vars, SVals, T) ; true ).
