kbs2QueryPrologInterlingua(AgentName,FormalogName,Query,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	perl5_method(Connection,'kbs2QueryPrologInterlingua',[AgentName,FormalogName,Query],Result).

kassert_prolog_interlingua(AgentName,FormalogName,Expr,Result) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	kbs2QueryPrologInterlingua(AgentName,FormalogName,['assert',Expr,Context],Result).

kquery_prolog_interlingua(AgentName,FormalogName,Expr,Result) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	kbs2QueryPrologInterlingua(AgentName,FormalogName,['query',Expr,Context],Result).

testPrologInterlingua :-
	kbs2Query(AgentName,FormalogName,['assert',['p','X'],Context],Result2),
	kbs2Query(AgentName,FormalogName,['assert',['p','Y'],Context],Result2),
	kassert_prolog_interlingua(AgentName,FormalogName,[completed,'Basic Task2'],Result1),
	print('Result1: '),print(Result1),nl,
	kquery_prolog_interlingua(AgentName,FormalogName,[completed,_],Result2),
	print('Result2: '),print(Result2),nl,
	kquery_prolog_interlingua(AgentName,FormalogName,[completed,temp],Result3),
	print('Result3: '),print(Result3),nl,
	true.