get_predicates(Predicates) :-
	setof(X,M^P^current_predicate(X,M:P),Predicates).

see_predicates :-
	get_predicates(Predicates),view(Predicates).

get_atoms(Atoms) :-
	findall(X,current_atom(X),Atoms).

see_atoms :-
	get_atoms(Atoms),view(Atoms).

hasSubstring(String,Substring) :-
	sub_string(String,_,_,_,Substring).

predicate_complete(Pattern,String) :-
	get_predicates(Completions),
	system:atom_string(Pattern,PatternString),
	member(Atom,Completions),
	system:atom_string(Atom,String),
	sub_string(String,0,_,_,PatternString).

constant_complete(Pattern,String) :-
	get_atoms(Completions),
	system:atom_string(Pattern,PatternString),
	member(Atom,Completions),
	system:atom_string(Atom,String),
	sub_string(String,0,_,_,PatternString).

hasSubatom(Atom,Subatom) :-
	system:atom_string(Atom,AtomString),
	system:atom_string(Subatom,SubatomString),
	hasSubstring(AtomString,SubatomString).

predicate_apropos_sa(Pattern,Atom) :-
	get_predicates(Completions),
	member(Atom,Completions),
	hasSubatom(Atom,Pattern).

predicate_apropos(Pattern,String) :-
	get_predicates(Completions),
	system:atom_string(Pattern,PatternString),
	member(Atom,Completions),
	system:atom_string(Atom,String),
	hasSubstring(String,PatternString).

constant_apropos(Pattern,String) :-
	get_atoms(Completions),
	system:atom_string(Pattern,PatternString),
	member(Atom,Completions),
	system:atom_string(Atom,String),
	hasSubstring(String,PatternString).

constant_apropos_print(Pattern) :-
	findall(String,constant_apropos(Pattern,String),Results),
	member(Result,Results),
	tab(4),write(Result),nl,
	fail.
constant_apropos_print(Pattern).

cap(Pattern) :-
	constant_apropos_print(Pattern).

%% cap(Pattern) :-
%% 	findall(Result,constant_apropos(Pattern,Result),Results),view(Results).

%% assert(:-(cap(Pattern),findall(Result,constant_apropos('has',Result),Results),view(Results))).

%% all_term_assertions(Constant,Assertions) :-

findallTerms_orig(M,Term,Matches) :-
	findall(Result,(current_predicate(_,M:P),catch(clause(M:P,Result),_,true)),Z),
	findall(Clause,(member(Clause,Z),occurs:sub_term(Term,Clause)),Matches).

findallTerms(M,Term,Matches) :-
	findall(Result,(current_predicate(_,M:P),catch(clause(M:P,Result),_,true)),Z),
	findall(Clause,(member(Clause,Z),term_contains_subterm(Term,Clause)),Matches).

%% %% Some useful functions
%% listing(listCompletions/1).

%% Write a function 

all_instances(Collection,Instances) :-
 	findall(Instance,isa(Instance,Collection),Instances).

%% %% already implemented elsewhere
%% all_term_assertions() :-
%% 	true.

all_isa(Instance,Collections) :-
	findall(Collection,isa(Instance,Collection),Collections).

%% comment() :-
%% 	true.

%% min_genls(SubCollection,SuperCollection) :-
%% 	all_genls(SubCollection,SuperCollections),
%% 	findall(Collection,(member(Collection,SuperCollections),findall(Collection2,genls(Collection2,Collection)))).

all_genls(SubCollection,SuperCollections) :-
	findall(SuperCollection,genls(SubCollection,SuperCollection),SuperCollections).

all_specs(SuperCollection,SubCollections) :-
	findall(SubCollection,genls(SubCollection,SuperCollection),SubCollections).

%% %% already implemented elsewhere
%% constant_complete() :-
%% 	true.

%% cyclify() :-
%% 	true.

:- dynamic cycloneConstant/1.
create_constant(Constant) :-
	nonvar(Constant),
	atomic(Constant),
	not(cycloneConstant(Constant)),
	assertz(cycloneConstant(Constant)).
%% %% Alternative implementation
%% create_constant(_) :-
%% 	true.

find_or_create_constant(Constant) :-
	create_constant(Constant).

%% cyc_assert() :-
%% 	%% what are all the things cyc would do.
%% 	true.

%% cyc_query() :-
%% 	true.

%% get_arglist() :-
%% 	true.

arity(Predicate,N) :-
	arities(Predicate,Arities),
	member(N,Arities).

arg1_isa(Predicate,Type) :-
	isa(Predicate,predicate),
	arity(Predicate,N),
	N >= 1,
	argIsa(Predicate,N,Type).

arg2_isa(Predicate,Type) :-
	isa(Predicate,predicate),
	arity(Predicate,N),
	N >= 2,
	argIsa(Predicate,N,Type).

arg3_isa(Predicate,Type) :-
	isa(Predicate,predicate),
	arity(Predicate,N),
	N >= 3,
	argIsa(Predicate,N,Type).

arg_isa(Predicate,M,Type) :-
	isa(Predicate,predicate),
	arity(Predicate,N),
	number(N),
	N >= M,
	argIsa(Predicate,M,Type).

cap(Search) :-
	constant_apropos(Search,Results),
	write_list(Results).

ca(Search,Results) :-
	constant_apropos(Search,Results).

all_term_assertions_print(Term) :-
	allTermAssertions(Term,Assertions),
	write_list(Assertions).

%% all_term_assertions_print_mt() :-
%% 	true.

%% all_instances_print() :-
%% 	true.

%% all_instances_print_mt() :-
%% 	true.

%% cyc_query_print() :-
%% 	true.

%% cyc_query_print_mt() :-
%% 	true.

%% all_isa_print() :-
%% 	true.

%% all_isa_print_mt() :-
%% 	true.

c(Constant) :-
	all_term_assertions_print(Constant),
	nl,nl,nl,
	write('comment:'),
	nl,nl,
	comment_print(Constant),
	nl.

comment_print(Constant) :-
	comment(Constant,Comment),
	write(Comment).
comment_print(Constant) :-
	true.

%% c_mt() :-
%% 	true.

p(Term) :-
	Term =.. [Predicate|Args],
	call(Term),
	last(Args,Arg),
	write_list(Arg).

q(Query) :-
	cyc_query(Query).

%%  q_mt() :-
%%  	true.

%%  describe_all_instances() :-
%%  	true.

%%  cc() :-
%%  	true.

%%  all_instances(Collection,Mt,ResultList) :-
%%  	true.

%%  all_term_assertions(Constant,ResultList) :-
%%  	true.

%%  all_isa(Constant,Mt,ResultList) :-
%%  	true.

%%  comment(Constant,ResultList) :-
%%  	true.

%%  min_genls(Collectionm,ResultList) :-
%%  	true.

%%  all_genls(Collectionm,ResultList) :-
%%  	true.

%%  all_specs(Collectionm,ResultList) :-
%%  	true.

%%  constant_complete(String,ResultList) :-
%%  	true.

%%  cyclify(Formula,Result) :-
%%  	true.

%%  create_constant(String,Result) :-
%%  	true.

%%  find_or_create_constant(String,Result) :-
%%  	true.

%%  constant_apropos(String,ResultList) :-
%%  	true.

%%  cyc_assert(Assertion,Mt,Result) :-
%%  	true.

%%  cyc_query(Query,Mt,Result) :-
%%  	true.

%%  %% get_arglist() :-
%%  %% 	true.

%%  arg1_isa(Relation,Collection) :-
%%  	true.

%%  arg2_isa(Relation,Collection) :-
%%  	true.