:- prolog_consult('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/algorithms.pl').
%% also create and measure performance of a tokenized version of
%% levenshtein, so it's more adroit at handling individual words

%% ANDY
:- prolog_consult('/var/lib/myfrdcsa/codebases/minor/universal-parser/languages/dcg/parseDialogInterfaceQueries.pl').

%% also create and measure performance of a tokenized version of
%% levenshtein, so it's more adroit at handling individual words

parseDialog(Query,Parse) :-
	parseDialogInterfaceQueryHelper(Query,Parse).

parseDialogInterfaceQueryHelper(Query,Parse) :-
	Filename = '/tmp/parser.txt',
	write_data_to_file(Query,Filename),
	%% view([filename,Filename,parse,Parse]),
	parseDialogInterfaceQuery(Filename,Parse).

%% naturalLanguageQuery(Question,Response) :-
%% 	Response = 'tacos',!.

naturalLanguageQuery(Question,Response) :-
	parseDialogInterfaceQueryHelper(Question,Response),!.
