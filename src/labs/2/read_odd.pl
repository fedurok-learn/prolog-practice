%% main(+InFname:str) is semidet.
%% read terms from file and select only 
%% odd integers
main(InFname) :-
  string_concat(InFname, '.res', OutFname),

  handle_file(InFname, read, read_terms, Nums),
  include(is_odd, Nums, OddNums),
  handle_file(OutFname, write, write_terms, OddNums).


%% handle_file(+Fname:str, +StreamType:atom, +HandlingProcedure:goal, ?Lst:list) is semidet.
handle_file(Fname, StreamType, HandlingProcedure, Lst) :-
  open(Fname, StreamType, Stream),
  call(HandlingProcedure, Stream, Lst),
  close(Stream).

%% is_odd(+N:int) is semidet.
is_odd(N) :- integer(N), 1 is N mod 2.

%% read_terms(+Stream:input_stream, +Lst:list) is semidet.
read_terms(Stream, []) :-
  at_end_of_stream(Stream).
read_terms(Stream, [X|L]) :-
  \+ at_end_of_stream(Stream),
  read(Stream, X),
  read_terms(Stream, L).

%% write_terms(+Stream:output_stream, +Lst:list) is semidet.
write_terms(_Stream, []) :- true.
write_terms(Stream, [X|L]) :-
  write_term(Stream, X, [nl(true), fullstop(true)]),
  write_terms(Stream, L).
