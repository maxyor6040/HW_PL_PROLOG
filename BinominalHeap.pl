

{/Binomial tree node/}
node(Key,FatherNode,ChildrenNodeList).

{/Binomial heap/}
bh([]).
bh([node(_,_,_)|Rest]).
emptyBH(NewBH):- NewBH is bh([]).

{/tree depth calculation/}
depth(node(_,_,[]),1).
depth(node(_,_,[LeftChild|Rest]),Val):- depth(LeftChild,X), Val is 1+X.


{/balancing a BH/}
balanceBH([],[]).
balanceBH([node(A,B,C)],[node(A,B,C)]).

balanceBH([Big,Small|Rest],[Big,Small|Rest]):- 
	depth(Small,D1),depth(Big,D2), D1=/=D2,
	

balanceBH([Big,Small|Rest],Res):- 
	depth(Small,D),depth(Big,D),
	Small is node(Key1,nil,Tail1), 
	Big is node(Key2,nil,Tail2), 
	key1<key2,
	X is node(key1,nil,[node(key2,X,Tail2)|Tail1]),
	balanceBH([X|Rest], Res).


balanceBH([Small,Big|Rest],Res):- 
	depth(Small,D),depth(Big,D),
	Small is node(Key1,nil,Tail1), 
	Big is node(Key2,nil,Tail2), 
	key1<key2,
	X is node(key1,nil,[node(key2,X,Tail2)|Tail1]),
	balanceBH([X|Rest], Res).



add(What, [], [node(What,nil,[])]).
add(What, [First|Rest], AfterBH):- 
	depth(First)>1,
	AfterBH is [node(What,nil,[]),First|Rest].
add(What, [First|Rest], AfterBH):- 
	depth(First)=:=1,
	balanceBH([node(What,nil,[]),First|Rest],AfterBH).







{/
balanceBH([Small,Big],Res):- 
	Small is node(Key1,nil,Tail1), 
	Big is node(Key2,nil,Tail2), 
	key1<key2,
	Res is [X],
	X is node(key1,nil,[node(key2,X,Tail2)|Tail1]).

balanceBH([Big,Small],Res):- 
	Small is node(Key1,nil,Tail1), 
	Big is node(Key2,nil,Tail2), 
	key1<key2,
	Res is [X],
	X is node(key1,nil,[node(key2,X,Tail2)|Tail1]).
/}
