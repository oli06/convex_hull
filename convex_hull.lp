%example 1
% cell(1,1).
% cell(3,1). 
% cell(5,3).
% cell(5,4).
% cell(5,5).
% cell(4,5).
% cell(4,4).
% cell(3,2).
% cell(2,3).
% cell(2,4).

%example 2
cell(1,0).
cell(0,2).
cell(3,2).
cell(2,3).
cell(4,3).
cell(3,4).
cell(5,5).
cell(1,5).

0{path(X,Y, A,B) : cell(A,B)}2 :- cell(X,Y). 

cellCount(S) :-  S = #count{X,Y: cell(X,Y)}.

%constraints
:- 2{path(_,_,C,D)}, cell(C,D). %remove all solutions, if there is a cell with more than one edge leading into
:- path(A,B,X,Y), path(X,Y,A,B). %remove all solutions, where a cellX leads into another cellY, and cellY leads back into cellX
:- W = #count{A: path(A, _,_,_)}, W == 0. %remove all solutions, where the number of paths equals zero
:- S = #count{X,Y: path(A,B,X,Y)}, S2  = #count{X,Y: path(X,Y,A,B)}, cell(A,B), (S+S2) > 2. % remove all solutions, where a cell is part in more than 2 paths 

:- path(A,B,C,D), not path(C,D, _,_).

left(A,B,C,D,Q):- path(A,B,C,D), Q = #count{X,Y: cell(X,Y), (C-A)*(Y-B) - (D-B)*(X-A) > 0}.
right(A,B,C,D,Q):- path(A,B,C,D), Q = #count{X,Y: cell(X,Y), (C-A)*(Y-B) - (D-B)*(X-A) < 0}.

:- path(A,B,C,D), left(A,B,C,D,L), right(A,B,C,D,R), L != 0, R != 0. %remove solution, if on both sides are points 


% :- path(A,B,C,D), left(A,B,C,D,L), right(A,B,C,D,R), R == 0, L != (S-2), cell(A,W), W > B, W < D, cellCount(S).
% :- path(A,B,C,D), left(A,B,C,D,L), right(A,B,C,D,R), L == 0, R != (S-2), cell(Q,B), Q > A, Q < C, cellCount(S).

% :- path(A,B,C,D), left(A,B,C,D,L), right(A,B,C,D,R), L == 0, R != (S-2), cell(A,W), W < B, W > D, cellCount(S).
% :- path(A,B,C,D), left(A,B,C,D,L), right(A,B,C,D,R), R == 0, L != (S-2), cell(Q,B), Q < A, Q > C, cellCount(S).

#show path/4.