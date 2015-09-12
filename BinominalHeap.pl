

/* Binomial tree node */
node(nil).
node(Key,FatherNode,ChildrenNodeList).

/* Binomial heap */
bh([]).
bh([node(_,_,_)|Rest]).
emptyBH([]).

/* tree depth calculation */
depth(node(_,_,[]),1).
depth(node(_,_,[LeftChild|Rest]),Val):- depth(LeftChild,LeftChildDepth), Val is 1+LeftChildDepth.

/* balancing a BH  - first 'arg' is input and second is output*/
balanceBH([],[]).

balanceBH([node(A,B,C)],[node(A,B,C)]).

balanceBH([Big,Small|Rest],Res):- 
	depth(Big,Db),
	depth(Small,Ds),
	Ds =\= Db,
	balanceBH([Small|Rest],Temp) ,
	Res = [Big|Temp].
	

balanceBH([Big,Small|Rest],Res):- 
	depth(Small,D),depth(Big,D),
	Small = node(Key1,nil,Tail1), 
	Big = node(Key2,nil,Tail2), 
	key1<key2,
	X = node(key1,nil,[node(key2,X,Tail2)|Tail1]),
	balanceBH([X|Rest], Res).


balanceBH([Small,Big|Rest],Res):- 
	depth(Small,D),depth(Big,D),
	Small = node(Key1,nil,Tail1), 
	Big = node(Key2,nil,Tail2), 
	key1<key2,
	X = node(key1,nil,[node(key2,X,Tail2)|Tail1]),
	balanceBH([X|Rest], Res).


/* add */
add(What, [], [node(What,nil,[])]).
add(What, [First|Rest], AfterBH):- 
	depth(First)>1,
	AfterBH = [node(What,nil,[]),First|Rest].
add(What, [First|Rest], AfterBH):- 
	depth(First)=:=1,
	balanceBH([node(What,nil,[]),First|Rest],AfterBH).







/**
* emptyBH(X),add(2,X,Y),add(3,Y,Z),add(1,Z,A).
* 
*/
