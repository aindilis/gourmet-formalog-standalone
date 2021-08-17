:- set_prolog_stack(global, limit(40 000 000 000)).
:- set_prolog_stack(trail,  limit(16 000 000 000)).
:- set_prolog_stack(local,  limit(16 000 000 000)).

%% FIXME, make it so it only runs it once

:- discontiguous schema/1.
:- multifile schema/1.

:- use_module(library(tsv_read_and_assert)).

:- consult('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/util.pl').

toxicity_dir('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/data/source/toxicity/').

load_toxicity :-
	toxicity_dir(ToxicityDir),
	directory_files(ToxicityDir,Files),
	member(Filename,Files),
	Filename \= '.',
	Filename \= '..',
	loadFile(Filename),
	fail.
load_toxicity.

loadFile(Filename) :-
	print_term([filename,Filename],[quoted(true)]),nl,
	toxicity_dir(ToxicityDir),
	print_term([toxicityDir,ToxicityDir],[quoted(true)]),nl,
	concat_atom([ToxicityDir,Filename],AbsoluteFilename),
	print_term([absoluteFilename,AbsoluteFilename],[quoted(true)]),nl,
	concat_atom([Predicate,'.csv'],Filename),
	print_term([filename,Filename,predicate,Predicate],[quoted(true)]),nl,
	atomic_list_concat([ToxicityDir,Predicate,'.pl'],'',OutputFile),
	(   read_in_and_assert_to_name(AbsoluteFilename,Predicate) ->
	    (	
		arities(Predicate,Arities),
		view([predicate,Predicate,arities,Arities]),
		foreach(member(Arity,Arities),getAllEntries(Predicate,Arity,[Schema|Entries])),
		with_output_to(atom(Output),(output(schema(Schema)),foreach(member(Fact,Entries),output(Fact)))),
		write_data_to_file(Output,OutputFile)
	    ) ; true),
	(   exists_file(OutputFile) -> qcompile(OutputFile) ; true),
	fail.
loadFile(_Filename).

output(Fact) :-
	write_term(Fact,[quoted(true)]),
	write('.'),
	nl.

getAllEntries(Pred,Arity,Entries) :-
	functor(Template,Pred,Arity),
	findall(Template,tsv_read_and_assert:Template,Entries).

:- load_toxicity.
