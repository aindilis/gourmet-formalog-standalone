:- prolog_consult('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/max_value.pl').

specialty_diet(Type,FDC_ID,Results) :-
	get_desc_nutrition_and_ingredients_for_fdc_id(FDC_ID,[_,_,_,Ingredients]),
	atomic_list_concat(IndividualIngredients,',',Ingredients),
	findall([Ingredient,Score],
		(
		 member(Ingredient,IndividualIngredients),
		 lookup_specialty_diet(Type,Ingredient,Score)
		),
		Scores),
	Results = [scores(Scores)].
	

lookup_specialty_diet(Type,Ingredient,Score) :-
	(   Type = fodmap ->
	    (	lookup_fodmap_diet(Ingredient,TmpScore) ->
		Score = TmpScore ;
		Score = undef) ;
	    Score = undef).

lookup_fodmap_diet(Ingredient,Score) :-
	findall(hasValue(Distance,TmpIngredient),
		(
		 fodmap_diet(TmpIngredient,TmpScore),
		 isub(Ingredient,TmpIngredient,true,Distance),
		 Distance > 0.25
		),
		AllResults),
	view([allResults,AllResults]),
	maxValue(AllResults,Result),
	view([result,Result]),
	Result = hasValue(_Distance,BestMatchingIngredient),
	fodmap_diet(BestMatchingIngredient,Score),
	!.
