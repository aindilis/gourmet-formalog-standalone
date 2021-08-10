:- dynamic prolog_files/2, prolog_files/3, md/2, possible/1.

:- multifile genlsDirectlyList/2, gourmetFormalogFlag/1.
:- discontiguous are/2, isa/2, gourmetFormalogFlag/1.

:- use_module(library(make)).
:- use_module(library(julian)).

:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/util.pl').
:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/dates/frdcsa/sys/flp/autoload/dates.pl').
:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/interactive-execution-monitor/frdcsa/sys/flp/autoload/args.pl').

gourmetFormalogFlag(not(debug)).
%% gourmetFormalogFlag(integrated).
gourmetFormalogFlag(independent).

viewIf(Item) :-
 	(   gourmetFormalogFlag(debug) -> 
	    view(Item) ;
	    true).

testGourmetFormalog :-
	true.
	
:- (gourmetFormalogFlag(integrated) -> 
    ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/gourmet_formalog.pl') ;
    (	%% trace,
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/cyc-common/frdcsa/sys/flp/autoload/cyc_api.pl'))).

:- loadGourmet.

:- nl,log_message('DONE LOADING GOURMET-FORMALOG.').
formalogModuleLoaded(gourmetFormalog).
