:- use_module(library(regex)).
:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/regex.pl').
:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/interactive-execution-monitor/frdcsa/sys/flp/autoload/args.pl').

:- dynamic contextHasFilename/2, contextHasFilename/3.

%% MONOTONIC PREDICATES MUST BE DECLARED MULTIFILE AND DYNAMIC AS WELL AS MONOTONICPREDICATE
are([atTime/2,naturalLanguageQueryHistory/2, naturalLanguageAnswerHistory/3, naturalLanguageCommandHistory/3],monotonicPredicate).
:- multifile atTime/2, naturalLanguageQueryHistory/2, naturalLanguageAnswerHistory/3, naturalLanguageCommandHistory/3.
:- dynamic atTime/2, naturalLanguageQueryHistory/2, naturalLanguageAnswerHistory/3, naturalLanguageCommandHistory/3.

predicateHasDefaultContext(contextHasFilename/2,'Org::FRDCSA::FreeLifePlanner::QLFPersistence::ContextToFilename').
predicateHasDefaultContext(contextHasFilename/3,'Org::FRDCSA::FreeLifePlanner::QLFPersistence::ContextToFilename').

qlf_persistence_load_context_to_filename_mapping(AgentName,FormalogName) :-
 	formalog_load_contexts(AgentName,FormalogName,['Org::FRDCSA::FreeLifePlanner::QLFPersistence::ContextToFilename']).

massert(AgentName,FormalogName,Clause,Result) :-
 	massert(AgentName,FormalogName,_Context,Clause,Result).

massert(AgentName,FormalogName,Clause,Context,Result) :-
	(   nonvar(Context) -> true ;
	    (	getVar(AgentName,FormalogName,'context',Var),
		kbs2Data(Var,Context))),
	massert_helper_1(AgentName,FormalogName,Clause,Context,Result).

massert_helper_1(AgentName,FormalogName,Clause,Context,Result) :-
	view([massert_helper_1(AgentName,FormalogName,Clause,Context,Result)]),
	Clause =.. [Pred|Args],
	length(Args,N),
	(   isa(Pred/N,monotonicPredicate) ->
	    massert_helper_2(AgentName,FormalogName,Clause,Context,Result) ;
	    fail).

massert_helper_2(AgentName,FormalogName,Clause,Context,Result) :-
	view([massert_helper_2(AgentName,FormalogName,Clause,Context,Result)]),
	DataDir = '/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/qlf-persistence/',
	context_to_filename(AgentName,FormalogName,Context,ContextFilename),
	atom_concat(DataDir,ContextFilename,Filename),
	with_output_to(atom(Data),(write_term(Clause,[quoted(true),fullstop(true)]),nl)),
	append_data_to_file(Data,Filename).

context_to_filename(AgentName,FormalogName,Context,ContextFilename) :-
	qlf_persistence_load_context_to_filename_mapping(AgentName,FormalogName),
	regex_replace(Context,'[^0-9A-Za-z-]','_',[],TmpContextFilename),
	atom_concat(TmpContextFilename,'.pl',ContextFilename),
	ensurefasserted_argt(AgentName,FormalogName,[term(contextHasFilename(Context,ContextFilename))],_Result).

context_to_necessarily_monotonic_filename(AgentName,FormalogName,Context,ContextFilename) :-
	qlf_persistence_load_context_to_filename_mapping(AgentName,FormalogName),
	regex_replace(Context,'[^0-9A-Za-z-]','_',[],TmpContextFilename),
	atom_concat(TmpContextFilename,'__necessarily_monotonic.pl',ContextFilename),
	ensurefasserted_argt(AgentName,FormalogName,[term(contextHasFilename(Context,necessarily_monotonic,ContextFilename))],_Result).

context_to_not_necessarily_monotonic_filename(AgentName,FormalogName,Context,ContextFilename) :-
	qlf_persistence_load_context_to_filename_mapping(AgentName,FormalogName),
	regex_replace(Context,'[^0-9A-Za-z-]','_',[],TmpContextFilename),
	atom_concat(TmpContextFilename,'__not_necessarily_monotonic.pl',ContextFilename),
	ensurefasserted_argt(AgentName,FormalogName,[term(contextHasFilename(Context,not_necessarily_monotonic,ContextFilename))],_Result).

refactor_kb_necessarily_monotonic_helper(AgentName,FormalogName,Clause,Context,Result) :-
	DataDir = '/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/qlf-persistence/',
	context_to_necessarily_monotonic_filename(AgentName,FormalogName,Context,ContextFilename),
	atom_concat(DataDir,ContextFilename,Filename),
	with_output_to(atom(Data),(write_term(Clause,[quoted(true),fullstop(true)]),nl)),
	append_data_to_file(Data,Filename).

refactor_kb_not_necessarily_monotonic_helper(AgentName,FormalogName,Clause,Context,Result) :-
	DataDir = '/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/qlf-persistence/',
	context_to_not_necessarily_monotonic_filename(AgentName,FormalogName,Context,ContextFilename),
	atom_concat(DataDir,ContextFilename,Filename),
	with_output_to(atom(Data),(write_term(Clause,[quoted(true),fullstop(true)]),nl)),
	append_data_to_file(Data,Filename).

qlf_persistence_load_database(AgentName,FormalogName) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,CurrentContext),
	context_to_filename(AgentName,FormalogName,CurrentContext,CurrentContextFilename),
	prolog_consult(CurrentContextFilename).

qlf_persistence_manually_refactor_contexts(AgentName,FormalogName,Contexts) :-
	getOption(loadContexts,LoadContexts),
	(   LoadContexts = true ->
	    (	
		getVar(AgentName,FormalogName,'context',Var),
		kbs2Data(Var,CurrentContext),
		forall(member(Context,Contexts),
		       (
			setContext(AgentName,FormalogName,Context),
			nl,write('REFACTORING CONTEXT: '),write(Context),nl,
			qlf_persistence_manually_refactor_context(AgentName,FormalogName)
		       )),
		setContext(AgentName,FormalogName,CurrentContext)
	    ) ;
	    true).


%% make a list of all contexts to be refactored

qlf_persistence_manually_refactor_context(AgentName,FormalogName) :-
	kquery(AgentName,FormalogName,nil,Bindings),
	forall(member(Binding,Bindings),%% view([Binding])). %%
	       refactor_kb(AgentName,FormalogName,Binding,_Result)).

%% refactor means to refactor to separate KB files for manual reintegration
refactor_kb(AgentName,FormalogName,Clause,Result) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	Clause =.. [Pred|Args],
	length(Args,N),
	(   isa(Pred/N,monotonicPredicate) ->
	    refactor_kb_necessarily_monotonic_helper(AgentName,FormalogName,Clause,Context,Result) ;
	    refactor_kb_not_necessarily_monotonic_helper(AgentName,FormalogName,Clause,Context,Result)).

refactor_contexts :-
	qlf_persistence_manually_refactor_contexts('Agent1','Yaswi1',
						   [
						    'Org::Cyc::BaseKB',
						    %% 'Org::Cyc::WSMContext::Debug1',
						    'Org::Cyc::WSMContext::fictional',
						    %% 'Org::Cyc::WSMContext::fictionalWSMContext1',
						    %% 'Org::Cyc::WSMContext::Org::Cyc::WSMContext::real',
						    'Org::Cyc::WSMContext::real'

						    %% %% NEED TO MAKE A
						    %% %% PREDICATE TO SAY
						    %% %% WHICH KBS WE HAVE
						    %% %% PERMISSION TO
						    %% %% MODIFY, WE DO NOT
						    %% %% FOR THESE :

						    %% 'Com::ByteLibrary::Metasites',
						    %% 'Org::FRDCSA::Academician',
						    %% 'Org::FRDCSA::Clear::DocData'
						   ]).

qlf_persistence_load(AgentName,FormalogName) :-
	getVar(AgentName,FormalogName,'context',Var),
	kbs2Data(Var,Context),
	DataDir = '/var/lib/myfrdcsa/codebases/minor/free-life-planner/data-git/qlf-persistence/',
	(   Context = 'Org::FRDCSA::FreeLifePlanner::QLFPersistence::ContextToFilename' ->
	    true ;
	    (	context_to_filename(AgentName,FormalogName,Context,ContextFilename),
		atom_concat(DataDir,ContextFilename,Filename),
		(   access_file(Filename,read) ->
		    (	
			nl,write('CONSULTING CONTEXT: '),write(Context),nl,
			prolog_consult(Filename),
			consult(Filename)
		    ) ; true))).


%% some problems, what if we later find that we want to make a
%% different assertion necessarily monotonic?  How do we refactor the
%% DB?  we could unassert from the DB and add to the File piecewise?

%% what if we have something that is sometimes monotonic, sometimes
%% not?  <- is that even possible?



%% we need to make per AgentName,FormalogName directories, so that if
%% a different application asserts something, it doesn't overwrite it.
%% Say a different app uses kassert.  what will be the results.


%% note that also this has to be updated for other applications besides FLP:
%% predicateHasDefaultContext(contextHasFilename/2,'Org::FRDCSA::FreeLifePlanner::QLFPersistence::ContextToFilename').
