generateResponseFromTemplate(Template,Response) :-
	view([template,Template]),
	with_output_to(atom(TemplateAtom),write_term(Template,[quoted(true)])),
	view([templateAtom,TemplateAtom]),
	(   Template = [command(assert(Assertion)),_,_] ->
	    (	view([assertion,Assertion,returnValue,1,answer,1]),
		(   Assertion = atTime(DateTime1,Tmp1) -> (SubAssertion = Tmp1) ; (SubAssertion = Assertion)),
		view([subAssertion,SubAssertion]),
		fixTimes(Assertion,FixedAssertion),
		with_output_to(atom(AssertionAtom),write_term(FixedAssertion,[quoted(true)])),
		view([assertion,Assertion,assertionAtom,AssertionAtom]),
		(   curGaeilgeArSeo(SubAssertion,Tmp2) ->
		    atom_concat('Got it, ',Tmp2,Response) ;
		    (	
			atom_concat('Okay, ',AssertionAtom,Response),
			view([response,Response])
		    )
		)
	    ) ;
	    (	Template = [command(query(Query)),_,_] ->
		(   view([query,Query,returnValue,1,answer,1]),
		    (	Query = atTimeQuery(DateTime2,Tmp3) -> (SubQuery = Tmp3) ; (SubQuery = Query)),
		    view([subQuery,SubQuery]),
		    fixTimes(Query,FixedQuery),
		    with_output_to(atom(QueryAtom),write_term(Query,[quoted(true)])),
		    view([query,Query,queryAtom,QueryAtom]),
		    (	curGaeilgeArSeo(SubQuery,Tmp4) ->
			(Response = Tmp4) ;
			(   
			    atom_concat('Okay, ',QueryAtom,Response),
			    view([response,Response])
			)
		    )
		) ; true)).
	
	
getGloss(Symbol,Gloss) :-
	hasEnglishGlosses(Symbol,[Gloss|_]).

fixTimes(Entry,FixedEntry) :-
	(   Entry = [Y-M-D,H:Mi:S] ->
	    (
	     Second is round(S),
	     FixedEntry = [Y-M-D,H:Mi:Second]
	    ) ;
	    (	is_list(Entry) ->
		findall(FixedSubEntry,(member(SubEntry,Entry),fixTimes(SubEntry,FixedSubEntry)),FixedEntry) ;
		(   Entry =.. [P|Args] ->
		    (
		     findall(FixedSubArgs,(member(SubArgs,Args),fixTimes(SubArgs,FixedSubArgs)),FixedArgs),
		     FixedEntry =.. [P|FixedArgs]
		     )	;
		    (	is_atom(Entry) -> FixedEntry = Entry ;
			true )))).
