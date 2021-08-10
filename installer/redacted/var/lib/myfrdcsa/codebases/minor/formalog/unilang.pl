:- dynamic kbs2Data/2.

:- consult('unilang-prolog-interlingua').
:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/larkc-cl/frdcsa/sys/flp/autoload/into_cycl_form.pl').

% we want to try to retrieve the unilang connection and bind it to the
% variable and finish the predicate successfully.

% if it doesn't exist, we want to create it then store it, then bind
% it and finish successfully.

% if we are unable to create it we want to fail with an error.

getVar(AgentName,FormalogName,VarName,Var) :-
	atomic_list_concat([AgentName,FormalogName,VarName],'-',Var).

connectToUniLang(AgentName,FormalogName,UniLangConnection) :-
	getVar(AgentName,FormalogName,'name',Var),
	catch(nb_getval(Var,UniLangConnection),_,openConnection(AgentName,FormalogName,UniLangConnection)).

openConnection(AgentName,FormalogName,UniLangConnection) :-
	perl5_eval('$Language::Prolog::Yaswi::swi_converter->pass_as_opaque("Formalog::UniLangProxy")',_),
	perl5_eval('use Formalog::UniLangProxy',_),
	perl5_method('Formalog::UniLangProxy', new, ['AgentName',AgentName,'FormalogName',FormalogName], [UniLangConnection]),
	getVar(AgentName,FormalogName,'name',Var),
	nb_setval(Var,UniLangConnection).
openConnection(AgentName,FormalogName,UniLangConnection) :-
	UniLangConnection = nil,
	write('ERROR: Cannot connect to UniLang.'),nl.

sublQuery(AgentName,FormalogName,Query,Result) :-
	connectToUniLang(AgentName,FormalogName,UniLangConnection),
	append([AgentName,FormalogName],Query,FinalQuery),
	perl5_method(UniLangConnection,'sublQuery',FinalQuery,Result).

kbs2Query(AgentName,FormalogName,Query,Result) :-
	connectToUniLang(AgentName,FormalogName,UniLangConnection),
	append([AgentName,FormalogName],Query,FinalQuery),
	perl5_method(UniLangConnection,'kbs2Query',FinalQuery,Result).

% kbs2Data('agent1-formalog1-context','Org::Cyc::BaseKB').

setContext(AgentName,FormalogName,Context) :-
	getVar(AgentName,FormalogName,'context',Var),
	retractall(kbs2Data(Var,_)),
	assertz(kbs2Data(Var,Context)).

setAsserter(AgentName,FormalogName,Asserter) :-
	getVar(AgentName,FormalogName,'asserter',Var),
	retractall(kbs2Data(Var,_)),
	assertz(kbs2Data(Var,Asserter)).

see2(Item) :-
	write_term(Item,[quoted(true)]),nl,!.

%% kretractall(AgentName,FormalogName,Term) :-
%% 	connectToUniLang(AgentName,FormalogName,Connection),
%% 	getVar(AgentName,FormalogName,'context',Var),
%% 	kbs2Data(Var,Context),
%% 	clause_to_string(Clause,String),
%% 	nl,write('string: '),write(String),nl,
%% 	kbs2Query(AgentName,FormalogName,['unassert',String,Context],Result),
%% 	see2([myResult,Result]).

kassert(AgentName,FormalogName,Clause,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	%% getVar(AgentName,FormalogName,'asserter',Var),
	%% kbs2Data(Var,Asserter),
	kassert_helper(AgentName,FormalogName,Clause,Context,Result).

	%% clause_to_string(Clause,String),
	%% nl,view([string,String,context,Context]),nl,
	%% kbs2Query(AgentName,FormalogName,['assert',String,Context],Result),
	%% see2([myResult,Result]).

	%% atom_string(Atom,String),
	%% atomic_list_concat(['eval (ps-queue-message "',Atom,'")'],'',Command),
	%% sendContents(AgentName,FormalogName,'Emacs-Client-2',Command,[],Result).

getDefaultContextForClause(Clause,Context) :-
	Clause =.. [Pred|Args],
	length(Args,Arity),
	predicateHasDefaultContext(Pred/Arity,Context).

kassert_argt(AgentName,FormalogName,Arguments,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	argt(Arguments,[term(Clause)]),
	(   argt(Arguments,[context(Context)]) ->
	    true ;
	    (	getDefaultContextForClause(Clause,Context) -> 
		true ;
		(   
		    getVar(AgentName,FormalogName,'context',Var),
		    kbs2Data(Var,Context)
		))),
	kassert_helper(AgentName,FormalogName,Clause,Context,Result).

kassert_helper(AgentName,FormalogName,Clause,Context,Result) :-
	(   (	getOption(useMassert,Value), Value = true) ->
	    (	massert(AgentName,FormalogName,Clause,Context,Result1) -> (DoKBS2Query = 0) ; (DoKBS2Query = 1)) ;
	    (	DoKBS2Query = 1)),
	(   (	DoKBS2Query = 1) ->
	    (	
		clause_to_string(Clause,String),
		nl,view([string,String,context,Context]),nl,
		kbs2Query(AgentName,FormalogName,['assert',String,Context],Result),
		see2([myResult,Result])
	    ) ; true).

testUnassert :-
	kunassert_argt('Agent1','Yaswi1',[database('freekbs2_unassert_test'),context('Org::FRDCSA::FreeKBS2'),term(has(x,y))],Result),
	view([result,Result]).

kunassert_argt(AgentName,FormalogName,Arguments,Result) :-
 	connectToUniLang(AgentName,FormalogName,Connection),
	view([a1]),
 	argt(Arguments,[term(Clause)]),
	view([a2,Clause]),
	into_cycl_form(Clause,Interlingua),
	view([a3,Interlingua]),
 	(   argt(Arguments,[database(Database)]) ->
 	    true ;
 	    (
	     Database = 'freekbs2'
 	    )),
	view([a4]),
 	(   argt(Arguments,[context(Context)]) ->
 	    true ;
 	    (
 	     getVar(AgentName,FormalogName,'context',Var),
 	     kbs2Data(Var,Context)
 	    )),
	view([a5]),
	perl5_method(Connection,'QueryAgentSWIPLPerl',[AgentName,FormalogName,'KBS2',['_perl_hash','Command','unassert','Asserter','guest','Formula',Interlingua,'Method','MySQL','Database',Database,'Context',Context,'_DoNotLog',1,'Flags',['_perl_hash','DontUnify',1]]],Result),
 	view([myResult,Result]).

%% testUnassertOrig :-
%% 	connectToUniLang('Agent1','Yaswi1',Connection),
%%  	%% perl5_method(Connection,'QueryAgentSWIPL',['Agent1','Yaswi1','KBS2',['Command','assert','Asserter','guest','Formula',['has','x','z'],'Method','MySQL','Database','freekbs2_unassert_test','Context','Org::FRDCSA::FreeKBS2','_DoNotLog',1]],Result),
%% 	perl5_method(Connection,'QueryAgentSWIPLPerl',['Agent1','Yaswi1','KBS2',['_perl_hash','Command','unassert','Asserter','guest','Formula',['isa',X,['p',X,Y]],'Method','MySQL','Database','freekbs2_unassert_test','Context','Org::FRDCSA::FreeKBS2','_DoNotLog',1,'Flags',['_perl_hash','DontUnify',1]]],Result),
%% 	view([result,Result]).


kquery(AgentName,FormalogName,Clause,Result) :-
	not(Clause = nil),
	connectToUniLang(AgentName,FormalogName,Connection),
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	clause_to_string(Clause,String),
	kbs2Query(AgentName,FormalogName,['query',String,Context],[[Result]]),
	write(kquery1),nl.

kquery(AgentName,FormalogName,nil,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	perl5_method(Connection,'QueryAgentSWIPL',[AgentName,FormalogName,'KBS2',['QueryAgent',1,'Command','all-asserted-knowledge','Context',Context,'OutputType','SWIPLI']],[[Result]]),
	write(kquery2),nl.
	% kbs2Query(AgentName,FormalogName,['query',nil,Context],Result).

print_list( [ ] ).
print_list( [ X | Y ] ):- nl, write('li: '), write(X), print_list( Y ).

maplist(_C_2, [], []).
maplist( C_2, [X|Xs], [Y|Ys]) :-
   call(C_2, X, Y),
   maplist( C_2, Xs, Ys).

trim_varname(Input,Output) :-
	with_output_to(string(I),write_term(Input,[quoted(true)])),
	atom_concat('_',O,I),
	Output = =(O,Input).

clause_to_string(Clause,String) :-
	term_variables(Clause, VarNames),
	maplist(trim_varname,VarNames,NewVarNames),
	OptsTmp = [quoted(true),variable_names(NewVarNames)],
	with_output_to(string(String),write_term(Clause,OptsTmp)).

sendContents(AgentName,FormalogName,Receiver,Contents,Data,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	perl5_method(Connection,'SendContentsSWIPL',[AgentName,FormalogName,Receiver,Data,Contents],TmpResult),
	view([tmpResult,TmpResult]),
	TmpResult = [[Result]].

queryAgent(AgentName,FormalogName,Receiver,Contents,Data,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	perl5_method(Connection,'QueryAgentSWIPL',[AgentName,FormalogName,Receiver,Data,Contents],TmpResult),
	view([tmpResult,TmpResult]),
	TmpResult = [[Result]].

queryAgentPerl(AgentName,FormalogName,Receiver,Contents,Data,Result) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	perl5_method(Connection,'QueryAgentSWIPLPerl',[AgentName,FormalogName,Receiver,Data,Contents],TmpResult),
	view([tmpResult,TmpResult]),
	TmpResult = [[Result]].

%% e.g. queryAgent('Agent1','Yaswi1','KBS2',['QueryAgent',1,'Command','all-asserted-knowledge','Context',Context,'OutputType','SWIPLI'],Result)

ensurekasserted(AgentName,FormalogName,Fact,_Result) :-
	(   not(Fact) -> (kassert(AgentName,FormalogName,Fact,_Result),view([fact,Fact])) ; true). %% view([notAsserted,Fact])).

ensurekasserted_argt(AgentName,FormalogName,Arguments,_Result) :-
	argt(Arguments,term(Fact)),
	view([fact,Fact]),
	(   not(Fact) -> (kassert_argt(AgentName,FormalogName,Arguments,_Result),view([fact,Fact])) ; true). %% view([notAsserted,Fact])).
