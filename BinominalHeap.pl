/* Binomial tree node (root node represents binomial tree) */
node(nil).
node(Key,ChildrenNodeList).

/* emptyBH */
emptyBH([]).

/*mergeBH*/
mergeBH([],BH2,BH2).

mergeBH([Head|Tail],BH2,MegrgedBH):-
	addTree(Head,BH2,NewBH2),
	mergeBH(Tail,NewBH2,MegrgedBH).

/*AddTree*/
addTree(Tree,[],[Tree]).

addTree(Tree,[FirstTree|Rest],NewBH):-
	depth(Tree,TreeDepth),
	depth(FirstTree,FirstTreeDepth),
	TreeDepth < FirstTreeDepth,
	NewBH = [Tree,FirstTree|Rest].

addTree(Tree,[FirstTree|Rest],NewBH):-
	depth(Tree,TreeDepth),
	depth(FirstTree,FirstTreeDepth),
	TreeDepth > FirstTreeDepth,
	addTree(Tree,Rest,BHWithTree),
	NewBH = [FirstTree|BHWithTree].

addTree(Tree,[FirstTree|Rest],NewBH):-
	depth(Tree,TreeDepth),
	depth(FirstTree,FirstTreeDepth),
	TreeDepth =:= FirstTreeDepth,
	Tree = node(TreeKey,TreeChildren), 
	FirstTree = node(FirstTreeKey,FirstTreeChildren), 
	TreeKey=<FirstTreeKey,
	addTree(node(TreeKey,[node(FirstTreeKey,FirstTreeChildren)|TreeChildren]),Rest,NewBH).

addTree(Tree,[FirstTree|Rest],NewBH):-
	depth(Tree,TreeDepth),
	depth(FirstTree,FirstTreeDepth),
	TreeDepth =:= FirstTreeDepth,
	Tree = node(TreeKey,TreeChildren), 
	FirstTree = node(FirstTreeKey,FirstTreeChildren), 
	TreeKey>FirstTreeKey,
	addTree(node(FirstTreeKey,[node(TreeKey,TreeChildren)|FirstTreeChildren]),Rest,NewBH).

/* tree depth calculation */
depth(node(_,[]),1).

depth(node(_,[LeftChild|Rest]),Val):- depth(LeftChild,LeftChildDepth), Val is 1+LeftChildDepth.

/* add */
add(What, [], [node(What,[])]).

add(What, [First|Rest], AfterBH):- 
	depth(First)>1,
	AfterBH = [node(What,[]),First|Rest].

add(What, [First|Rest], AfterBH):- 
	depth(First)=:=1,
	addTree(node(What,[]),[First|Rest],AfterBH).

/*fetchMin*/
fetchMin(Into,[node(Into,[])],[]).

fetchMin(CurrentKey,[node(CurrentKey,CurrentTreeChildren),SecondTree|RestOfBH],AfterBH):-
	fetchMin(MinInRestOfBH,[SecondTree|RestOfBH],_),
	MinInRestOfBH>CurrentKey,
	mergeBH(CurrentTreeChildren, [SecondTree|RestOfBH], AfterBH).

fetchMin(Into,[CurrentTree,SecondTree|Rest],[CurrentTree|AfterBH]):-
	CurrentTree = node(CurrentKey,_),
	fetchMin(MinInRestOfBH,[SecondTree|RestOfBH],AfterBH),
	MinInRestOfBH=<CurrentKey.

/**
* emptyBH(X),add(2,X,Y),add(3,Y,Z),add(1,Z,A).
* 
*/
