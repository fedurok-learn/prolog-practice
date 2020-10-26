%% merge(+L1:list, +L2:list, -L:list) is det. v1
merge([H1|T1], [H2|T2], [H|T]) :-
    H1 < H2, H = H1, merge(T1, [H2|T2], T). 
merge([H1|T1], [H2|T2], [H|T]) :-
    H1 >= H2, H = H2, merge([H1|T1], T2, T).
merge(L1, [], L1).
merge([], L2, L2).

%% reverse(+L:list, -R:list) is det. v2
reverse([], []).
reverse([H|T], R) :- reverse(T, RT), append(RT, [H], R). 

%% qadd(+Q:list, +El:any, -R:list) is det. v3
enqueue(Q, El, R) :-
  length(Q, Len),
  nth0(Len, R, El, Q).

%% list_remove(+L:list, +El:any, -R:list) is det. v4
list_remove([], _El, []).
list_remove([El|T], El, R) :- list_remove(T, El, R), !.
list_remove([H|T], El, [RH|RT]) :- RH = H, list_remove(T, El, RT).

%% v5
%% list_remove(from v4) to remove from set of characters
%% qadd(from v3) to add to set of characters
%% rename the predicates accordingly

%% list_concat(+L1:list, +L2:list, -R:list) is det. v6
list_concat([], L2, L2).
list_concat([H|T], L2, [RH|RT]) :- RH = H, list_concat(T, L2, RT).

%% list_intersection(+L1:list, +L2:list, -R:list) is det. v7
list_intersection([], _L2, []).
list_intersection([H|T], L2, [H|RT]) :- member(H, L2), !, list_intersection(T, L2, RT).
list_intersection([_H|T], L2, R) :- list_intersection(T, L2, R).

%% list_diff(+L1:list, +L2:list, -R:list) is det. v8
list_diff([], _L2, []).
list_diff([H|T], L2, R):- member(H, L2), !, list_diff(T, L2, R).
list_diff([H|T], L2, [H|RT]) :- list_diff(T, L2, RT).

%% list_symdiff(+L1:list, +L2:list, -R:list) is det. v9
list_symdiff(L1, L2, R) :- 
    list_diff(L1, L2, R12),
    list_diff(L2, L1, R21),
    list_concat(R12, R21, Rsymdiff),
	list_to_set(Rsymdiff, R). % builtin

%% list_strip(+L:list, -R:list) is det. v10
list_strip([_H|T], R) :- strip_end(T, R).

%% strip_end(+L:list, -R:list) is det.
strip_end([_H], []).
strip_end([H|T], [H|RT]) :- strip_end(T, RT), !.

%% get_by_key(+D:list[list[2]], K:any, -R:any) is semidet. v11
get_by_key([[K, V]|_T], K, V).
get_by_key([_H|T], K, V) :- get_by_key(T, K, V).       

%% dict_insert(+D:list[list[2]], K:any, V:any, -R:any) is det. v12
dict_insert([], K, V, [[K, V]]).
dict_insert([[K, _V1]|T], K, V2, [[K, V2]|T]).
dict_insert([H|T], K, V, [H|RT]) :- dict_insert(T, K, V, RT), !.
             
%% btree_serach(+T:list[int, any, list[...], list[...]], K:int, V:any) is semidet. v13
btree_search([HK, HV|_T], HK, HV).
btree_search([HK, _HV, _L, R], K, V) :- K >= HK, btree_search(R, K, V).
btree_search([HK, _HV, L, _R], K, V) :- K < HK, btree_search(L, K, V).

%% tree_insert(+T:tree, K:int, V:any, +RT:tree) is det. v14
btree_insert([], HK, HV, [HK, HV, [], []]).
btree_insert([HK, HV, L, R], K, V, [HK, HV, L, RT]) :- K >= HK, btree_insert(R, K, V, RT).
btree_insert([HK, HV, L, R], K, V, [HK, HV, RT, R]) :- K < HK, btree_insert(L, K, V, RT).
            
            
