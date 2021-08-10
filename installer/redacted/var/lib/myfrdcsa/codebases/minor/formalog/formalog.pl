:- dynamic option/2, loaded/1, necessarilyMonotonicContexts/1.
:- multifile necessarilyMonotonicContexts/1.

setOption(Option,Value) :-
	retractall(option(Option,_)),
	assertz(option(Option,Value)).

getOption(Option,Value) :-
	option(Option,Value).

%% :- setOption(loadContexts,fail).
:- setOption(loadContexts,true).

assert_list( [ ] ).
assert_list( [ X | Y ] ):- write('Asserting: '),write_term(X,[quoted(true)]),assert(X),nl,assert_list( Y ).

formalog_load_database(AgentName,FormalogName) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	findall(TmpContext,(necessarilyMonotonicContexts(List),member(TmpContext,List)),Contexts),
	(   member(Context,Contexts) -> true ;
	    (	
		kquery(AgentName,FormalogName,nil,Bindings),
		assert_list(Bindings)
	    )),
	qlf_persistence_load(AgentName,FormalogName).

formalog_init(AgentName,FormalogName) :-
	formalog_load_database(AgentName,FormalogName),
	formalog_toplevel(AgentName,FormalogName).

formalog_not_yet_implemented :-
				% called_by(Goal,Called),
	write('Function not yet implemented.'),nl,
				% throw(error()),
	true.

% fabolish(PredicateIndicator) :-
% 	formalog_not_yet_implemented.

% fabolish(Name,Arity) :-
% 	formalog_not_yet_implemented.

% fcopy_predicate_clauses(From,To) :-
% 	formalog_not_yet_implemented.

% fredefine_system_predicate(Head) :-
% 	formalog_not_yet_implemented.

% fretract(Term) :-
% 	formalog_not_yet_implemented.

%% fretractall(AgentName,FormalogName,Term) :-
%% 	kretractall(AgentName,FormalogName,Term),
%% 	retractall(Term).
	
%% fassertz(AgentName,FormalogName,Term,Result) :-
%% 	kassert(AgentName,FormalogName,Term,[[Result1,Error]]),
%% 	Result = [[Result1,Error]],
%% 	fassertz_handle(AgentName,FormalogName,Term,Result1,Error).

% fasserta(Term) :-
% 	formalog_not_yet_implemented.

testFunassert :-
	funassert_argt('Agent1','Yaswi1',[database('freekbs2_unassert_test'),context('Org::FRDCSA::FreeKBS2'),term(isa(x,y))],Result),
	view([result,Result]).

funassert(AgentName,FormalogName,Term,Result) :-
	Arguments = [term(Term)],
	kunassert_argt(AgentName,FormalogName,Arguments,Result),
	unassert(Term).

funassert_argt(AgentName,FormalogName,Arguments,Result) :-
	funassertz_argt(AgentName,FormalogName,Arguments,Result).

funassertz_argt(AgentName,FormalogName,Arguments,Result) :-
	%% Arguments = [database('freekbs2_unassert_test'),context('Org::FRDCSA::FreeKBS2'),term(has(x,y))]
	kunassert_argt(AgentName,FormalogName,Arguments,Result),
	%% Result = [[Result1,Error]],
	Result1 = 1,
	funassertz_handle_argt(AgentName,FormalogName,Arguments,Result1,Error).

funassertz_handle_argt(AgentName,FormalogName,Term,Result,_) :-
	not(Result = 1),
	argt(Arguments,[term(Term)]),
	write('Could not unassert value: '),write_canonical(Term),nl.
funassertz_handle_argt(AgentName,FormalogName,Arguments,1,_) :-
	argt(Arguments,[term(Term)]),
	unassert(Term).


fassertz(AgentName,FormalogName,Term,Result) :-
	kassert(AgentName,FormalogName,Term,[[Result1,Error]]),
	Result = [[Result1,Error]],
	fassertz_handle(AgentName,FormalogName,Term,Result1,Error).

fassertz_handle(AgentName,FormalogName,Term,Result,_) :-
	not(Result = 1),
	write('Could not assert value: '),write_canonical(Term),nl.
fassertz_handle(AgentName,FormalogName,Term,1,_) :-
	assert(Term).

fquery(AgentName,FormalogName,Term,Result) :-
	kquery(AgentName,FormalogName,Term,Result).

fassert(AgentName,FormalogName,Term,Result) :-
	fassertz(AgentName,FormalogName,Term,Result).

fassert_argt(AgentName,FormalogName,Arguments,Result) :-
	fassertz_argt(AgentName,FormalogName,Arguments,Result).

fassertz_argt(AgentName,FormalogName,Arguments,Result) :-
	kassert_argt(AgentName,FormalogName,Arguments,[[Result1,Error]]),
	Result = [[Result1,Error]],
	fassertz_handle_argt(AgentName,FormalogName,Arguments,Result1,Error).

fassertz_handle_argt(AgentName,FormalogName,Term,Result,_) :-
	not(Result = 1),
	argt(Arguments,[term(Term)]),
	write('Could not assert value: '),write_canonical(Term),nl.
fassertz_handle_argt(AgentName,FormalogName,Arguments,1,_) :-
	argt(Arguments,[term(Term)]),
	assert(Term).

ensurefasserted(AgentName,FormalogName,Fact,_Result) :-
	(   not(Fact) -> (fassert(AgentName,FormalogName,Fact,_Result),view([fact,Fact])) ; true). %% view([notAsserted,Fact])).

ensurefasserted_argt(AgentName,FormalogName,Arguments,_Result) :-
	argt(Arguments,term(Fact)),
	view([fact,Fact]),
	(   not(Fact) -> (fassert_argt(AgentName,FormalogName,Arguments,_Result),view([fact,Fact])) ; true). %% view([notAsserted,Fact])).

% fasserta(Term,Reference) :-
% 	formalog_not_yet_implemented.

% fassertz(Term,Reference) :-
% 	formalog_not_yet_implemented.

% fassert(Term,Reference) :-
% 	formalog_not_yet_implemented.

% frecorda(Key,Term,Reference) :-
% 	formalog_not_yet_implemented.

% frecorda(Key,Term) :-
% 	formalog_not_yet_implemented.

% frecordz(Key,Term,Reference) :-
% 	formalog_not_yet_implemented.

% frecordz(Key,Term) :-
% 	formalog_not_yet_implemented.

% frecorded(Key,Term,Reference) :-
% 	formalog_not_yet_implemented.

% frecorded(Key,Term) :-
% 	formalog_not_yet_implemented.

% ferase(Reference) :-
% 	formalog_not_yet_implemented.

% finstance(Reference,Term) :-
% 	formalog_not_yet_implemented.

% fflag(Key,Old,New) :-
% 	formalog_not_yet_implemented.

squelch(_) :-
	true.

formalog_load_contexts(AgentName,FormalogName,Contexts) :-
	getOption(loadContexts,LoadContexts),
	(   LoadContexts == true ->
	    (	
		getVar(AgentName,FormalogName,'context',Var),
		kbs2Data(Var,CurrentContext),
		forall(member(Context,Contexts),
		       (   
			   loaded(contextFn(Context)) -> true ;
			   (   
			       setContext(AgentName,FormalogName,Context),
			       nl,write('LOADING CONTEXT: '),write(Context),nl,
			       formalog_load_database(AgentName,FormalogName),
			       assert(loaded(contextFn(Context)))
			   )
		       )),
		setContext(AgentName,FormalogName,CurrentContext)
	    ) ; (write('loadContexts not enabled, skipping loading contexts...'),nl)).

:- consult(unilang).
:- consult('formalog-agent').
:- consult('qlf_persistence').
