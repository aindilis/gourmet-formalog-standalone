:- use_module(library(clpfd)).

maxValue([], R, R).
maxValue([hasValue(X,K1)|Xs], hasValue(WK,K2), R) :-
	compareValue(>,X,WK),
	maxValue(Xs, hasValue(X,K1), R).
maxValue([hasValue(X,K1)|Xs], hasValue(WK,K2), R) :-
	(   compareValue(<,X,WK) ; compareValue(=,X,WK)),
	maxValue(Xs, hasValue(WK,K2), R).
maxValue([hasValue(X,K1)|Xs], R) :-
	maxValue(Xs, hasValue(X,K1), R).

%% compareValue(Order,A,B) :-
%% 	zcompare(Order,A,B).

compareValue(>,TmpA,TmpB) :-
	A is round(TmpA * 10000000000000000000),
	B is round(TmpB * 10000000000000000000),
	A #> B.
compareValue(<,TmpA,TmpB) :-
	A is round(TmpA * 10000000000000000000),
	B is round(TmpB * 10000000000000000000),
	A #< B.
compareValue(=,TmpA,TmpB) :-
	A is round(TmpA * 10000000000000000000),
	B is round(TmpB * 10000000000000000000),
	A #= B.

testMaxValue(Max) :-
	maxValue([hasValue(1,x),hasValue(2,y)],Max).

testMaxValue(Max) :-
	maxValue([hasValue(1,x),hasValue(5,y),hasValue(2,z),hasValue(4,a)],Max).

testMaxValue(Max) :-
	maxValue([hasValue(0.7669616519174041,'pea protein'),hasValue(0.7669616519174041,'egg protein'),hasValue(0.3500609508329947,'einkorn flour'),hasValue(0.8454073572556985,'soy protein'),hasValue(0.6305256869772999,'sacha lnchi protein'),hasValue(0.73928635467097,'rice protein'),hasValue(0.600990099009901,roti),hasValue(0.3380559540889526,'biscuits wheat'),hasValue(0.3984276729559748,buckwheat),hasValue(0.9199999999999999,'whey protein isolated'),hasValue(0.8941176470588236,'whey protein concentrated'),hasValue(0.90625,'whey protein hydrolyzed'),hasValue(0.6256079766536965,wheat)],Max).
