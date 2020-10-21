%% mergesort(+Lst:list, +Sorted:list) is det.
mergesort([], []).
mergesort([N], [N]).
mergesort(Lst, Sorted) :-
    split(Lst, Half1, Half2),
    mergesort(Half1, Sorted1),
    mergesort(Half2, Sorted2),
    merge(Sorted1, Sorted2, Sorted).

%% split(+L:list, -A:list, -B:list) is det.
split(L, A, B) :- append(A, B, L), same_length(A, B).
split([H|T], A, B) :- split(T, AT, B), A = [H|AT].

%% merge(+L1:list, +L2:list, -L:list) is det.
merge([H1|T1], [H2|T2], [H|T]) :-
    H1 < H2, H = H1, merge(T1, [H2|T2], T). 
merge([H1|T1], [H2|T2], [H|T]) :-
    H1 >= H2, H = H2, merge([H1|T1], T2, T).
merge(L1, [], L1).
merge([], L2, L2).
