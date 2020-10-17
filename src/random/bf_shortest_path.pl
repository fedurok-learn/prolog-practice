%% https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Shortest_path_with_direct_weights.svg/1200px-Shortest_path_with_direct_weights.svg.png
%% this program is to be done in future

distance(a, b, 4). 
distance(a, c, 2).
distance(b, c, 5).
distance(b, d, 10).
distance(c, e, 3).
distance(e, d, 4).
distance(d, f, 11).

shortest_path(X, X, R) :- R = 0.

shortest_path(X, Y, R) :-
    distance(X, Z, D),
    shortest_path(Z, Y, R2),
    R is D + R2.
