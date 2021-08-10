:- set_prolog_stack(global, limit(40 000 000 000)).
:- set_prolog_stack(trail,  limit(8 000 000 000)).
:- set_prolog_stack(local,  limit(8 000 000 000)).

%% /var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes/mm.pl

gourmetFormalogFlag(neg(test)).

loadGourmet :-
	(   gourmetFormalogFlag(test) -> true ;
	    (	
		ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/fooddata/fooddata'),
		load_fooddata,
		ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/recipes/mm')
	    )),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/multifile-and-dynamic-directives.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/cyclone/frdcsa/sys/flp/autoload/kbs.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/free-life-planner/lib/util/util.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/dialog-interface/frdcsa/sys/flp/dialog_interface.pl'),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/flp-pddl/prolog-pddl-parser/prolog-pddl-3-0-parser-20140825/readFileI.pl'),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/parsers/dcgs/dcgs.pl'),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/parsers/ingredients.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/parsers/foods.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/parsers/branded_food__ingredients.pl'),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/receipts/inventory_import.pl'),
	
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/interactive-execution-monitor/frdcsa/sys/flp/autoload/args.pl'),

	(   gourmetFormalogFlag(test) -> true ;
	    (	
		ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet/prolog/wnprolog.pl'),
		ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/wordnet/gourmet_wordnet.pl'),
		ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/receipts/inventory_import_data.pl'),
		wnCacheAllSpecs(food)
	    )),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_logic.pl'),

	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_specialty_diets.pl'),
	ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/gourmet_fodmap.pl'),

	true.

