%% range(+End:int) is det
range(End) :- range(0, End).

%% range(+Start:int, +End:int) is det
range(Start, End) :- Start = End, !.

range(Start, End) :- 
    writeln(Start), 
    NewStart is Start + 1,
    range(NewStart, End).
