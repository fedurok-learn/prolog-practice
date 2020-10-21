%% unique(+Lst:list, -Unique:list) is det.
unique(Lst, Unique) :- unique(Lst, [], Unique).
    
unique([], _Acc, []).
unique([H|T], Acc, Unique) :- 
    in(H, Acc), unique(T, Acc, Unique).
unique([H|T], Acc, [UH|UT]) :- 
    UH = H, unique(T, [H|Acc], UT).
    
%% in(+El, +Lst:list) is det.
in(El, [H|_T]) :- H = El.
in(El, [_H|T]) :- in(El, T).
