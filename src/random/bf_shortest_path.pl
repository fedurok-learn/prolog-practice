%% https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/Shortest_path_with_direct_weights.svg/1200px-Shortest_path_with_direct_weights.svg.png

distance(a, b, 4). 
distance(a, c, 2).
distance(b, c, 5).
distance(b, d, 10).
distance(c, e, 3).
distance(e, d, 4).
distance(d, f, 11).

%% shortest_path(+A:atom, +B:atom, -R:int) is semidet.
%% shortest path between nodes in directed graph
shortest_path(A, B, R) :- 
    findall(X, path(A, B, [], 0, X), Lst),
    min_list(Lst, R).

%% path(+A:atom, +B:atom, +Visited:list, +Acc:int, -R:int) is nondet.
%% @param A and B - first nodes
%% @param Visited - list of already visited nodes
%% @param Acc - accumulator so that we could
%% incorporate tail call recursion optimisation
%% @param R - resulting path length
%% distance of path between two nodes in directed graph
path(A, A, _Visited, Acc, Acc).
path(A, B, Visited, Acc, R) :-
    distance(A, C, AC),
    \+ member(C, Visited),
    NewAcc is Acc + AC,
    path(C, B, [C|Visited], NewAcc, R).
