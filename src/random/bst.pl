%% https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Binary_search_tree.svg/1200px-Binary_search_tree.svg.png

%% dynamic to allow dynamic insertion and deletion 
%% from binary search tree
:- dynamic bst_left/2.
:- dynamic bst_right/2.

bst_left(8, 3).
bst_left(3, 1).
bst_left(6, 4).
bst_left(14, 13).

bst_right(8, 10).
bst_right(3, 6).
bst_right(10, 14).
bst_right(6, 7).

%% bst_insert(+Root:int +Node:int) is nondet.
bst_insert(Root, Node) :- 
    Root >= Node, 
    (
    	bst_left(Root, RootLeft) -> 
    	bst_insert(RootLeft, Node) ; 
    	assertz(bst_left(Root, Node))
    ). 

bst_insert(Root, Node) :- 
    Root < Node, 
    (
    	bst_right(Root, RootRight) -> 
    	bst_insert(RootRight, Node) ; 
    	assertz(bst_right(Root, Node))
    ).
