rec(Title,Ingredients,Directions) :-
	recipe(Title,Ing,Dir),
	Ing =.. ['_prolog_list'|Ingredients],
	Dir =.. ['_prolog_list'|Directions].

searchRecipesByTitle(Search,Recipes) :-
	findall(rec(A,B,C),(rec(A,B,C),like_case_insensitive(A,Search)),Recipes).

searchRecipeTitlesByDescription(Search,Titles) :-
	findall(A,(rec(A,B,C),like_case_insensitive(A,Search)),TmpTitles),
	sort(TmpTitles,Titles).

searchRecipesByMatchingIngredient(Search,Recipes) :-
	findall(rec(A,B,C),(rec(A,B,C),(member(ing(_Qty,_Unit,Name),B),nonvar(Name),like_case_insensitive(Name,Search))),Recipes).

searchRecipeTitlesByMatchingIngredient(Search,Titles) :-
	nonvar(Search),
	findall(A,(rec(A,B,C),(member(ing(_Qty,_Unit,Name),B),nonvar(Name),like_case_insensitive(Name,Search))),Titles).

getShoppingListForRecipes(Recipes,ShoppingList) :-
	member(rec(Title,Ings,Dirs),Recipes),
	view([title,Title]),
	member(ing(_,_,Ing),Ings),
	view([ing,Ing]),
	tryToMatchIngredientToFoodData(Ing,Matches),
	print_term([ing(Ing),matches(Matches)],[quoted(true)]),nl,
	fail.
getShoppingListForRecipes(Recipes,ShoppingList).

tryToMatchIngredientToFoodData(Ing,Matches) :-
	food_nutrition(Ing,Matches).


testRecipes :-
	searchRecipesByTitle('Freezer',Recipes),
	getShoppingListForRecipes(Recipes,List).

%% atTimeQuery([2020-01-06,19:18:12],hasInventory(X,Y,Z)).

countHowManyFoodsHaveInputFoods :-
	findall(FDC_ID,food(FDC_ID,_,_,_,_),FDC_IDs1),
	length(FDC_IDs1,L1),
	findall(FDC_ID,(food(FDC_ID,_,_,_,_),input_food(_,FDC_ID,_,_,_,_,_,_,_,_,_,_,_)),FDC_IDs2),
	length(FDC_IDs2,L2),
	findall(FDC_ID,(food(FDC_ID,_,_,_,_),input_food(_,_,FDC_ID,_,_,_,_,_,_,_,_,_,_)),FDC_IDs3),
	length(FDC_IDs3,L3),
	view([l1,L1,l2,L2,l3,L3]).

printInputFoods :-
	findall([FDC_ID,DESC],(food(FDC_ID,_,DESC,_,_),input_food(_,_,FDC_ID,_,_,_,_,_,_,_,_,_,_)),Results),
	print_term(Results,[quoted(true)]).

printFoods :-
	findall([FDC_ID,DESC],(food(FDC_ID,_,_,_,_),input_food(_,FDC_ID,_,_,_,_,DESC,_,_,_,_,_,_)),Results),
	print_term(Results,[quoted(true)]).

getFoodDescFromFDCID(FDC_ID,DESC) :-
	food(FDC_ID,_,DESC,_,_).

getBarcodeFromFDCID(FDC_ID,Barcode) :-
	branded_food(FDC_ID,_,Barcode,_,_,_,_,_,_,_,_).

getBarcodeAtomFromFDCID(FDC_ID,BarcodeAtom) :-
	branded_food(FDC_ID,_,Barcode,_,_,_,_,_,_,_,_),
	atom_number(BarcodeAtom,Barcode).

foodNutritionFromFDCID(FDC_ID) :-
	getFoodDescFromFDCID(FDC_ID,DESC),
	food_nutrition(DESC,_).

lookup_branded_food_by_barcode(Barcode,FDC_ID,DESC) :-
	branded_food(FDC_ID,_,Barcode,_,_,_,_,_,_,_,_),
	like(Barcode,SearchBarcode),
	getFoodDescFromFDCID(FDC_ID,DESC).

lookup_branded_food_by_barcode_atom(BarcodeAtom,FDC_ID,DESC) :-
	atom_number(BarcodeAtom,Barcode),
	branded_food(FDC_ID,_,Barcode,_,_,_,_,_,_,_,_),
	like(Barcode,SearchBarcode),
	getFoodDescFromFDCID(FDC_ID,DESC),
	!.

search_branded_food_by_barcode_search(SearchBarcode,Barcode,FDC_ID,DESC) :-
	branded_food(FDC_ID,_,Barcode,_,_,_,_,_,_,_,_),
	like(Barcode,SearchBarcode),
	getFoodDescFromFDCID(FDC_ID,DESC).

search_branded_food_by_description_search(SearchDescription,FDC_ID,DESC,Barcode) :-
	food(FDC_ID,_,Description,_,_),
	like_case_insensitive(Description,SearchDescription),
	getFoodDescFromFDCID(FDC_ID,DESC),
	getBarcodeFromFDCID(FDC_ID,Barcode).

%% Rockstar Pure Zero Silver Ice Energy Drink, 16 Fl. Oz.

search_branded_food_by_description_text_distance_search(SearchDescription,FinalResults) :-
	findall([FDC_ID,Description,Distance],
		(
		 food(FDC_ID,_,Description,_,_),
		 isub(SearchDescription,Description,true,Distance),
		 Distance > 0.85
		),
		Results),
	predsort(nthcompare(3),Results,Sorted),
	reverse(Sorted,ReverseSorted),
	sublist(ReverseSorted,1,10,FinalResults),
	!.

get_desc_nutrition_and_ingredients_for_fdc_id(FDC_ID_Atom,All) :-
	atom_number(FDC_ID_Atom,FDC_ID),
	getBarcodeAtomFromFDCID(FDC_ID,BarcodeAtom),
	get_all_for_barcode_atom(BarcodeAtom,All).

get_all_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,NutritionSearchResults,Ingredients]) :-
	get_nutrition_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,NutritionSearchResults]),
	get_ingredients_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,Ingredients]).

get_nutrition_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,NutritionSearchResults]) :-
	lookup_branded_food_by_barcode_atom(BarcodeAtom,FDC_ID,DESC),
	food_nutrition_by_fdc_id(FDC_ID,NutritionSearchResults).

get_ingredients_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,Ingredients]) :-
	lookup_branded_food_by_barcode_atom(BarcodeAtom,FDC_ID,DESC),
	food_ingredients_by_fdc_id(FDC_ID,Ingredients).

has_high_fructose_corn_syrup(BarcodeAtom) :-
	has_ingredient(BarcodeAtom,'HIGH FRUCTOSE CORN SYRUP').

has_ingredient(BarcodeAtom,Allergen) :-
	get_ingredients_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,Ingredients]),
	%% FIXME: parse the ingredients first, then check
	like_case_insensitive(Ingredients,Allergen).

check_ingredient(Ingredient) :-
	allSpecs(food,Specs),
	downcase_atom(Ingredient,DCIngredient),
	member(DCIngredient,Specs).

meredithTest :-
	findnsols(1,rec(X,Y,Z),rec(X,Y,Z),Results).

%% search_food_data_central_with_description(BarcodeAtom,Results,Description) :-
%% 	search_food_data_central(BarcodeAtom,Results),
%% 	argl(Results,description,Description).

search_food_data_central(BarcodeAtom,[invFn,invFn(idFn(gourmetFDC,FDC_ID),barcodeFn(BarcodeAtom)),invCat,Branded_Food_Category,flpNameFn,ProductIDDescriptive,brandOwner,Brand_Owner,description,DESC,nutrition,NutritionSearchResults,ingredients,Ingredients,mappedNutritionInfo,MappedNutritionInfo,mappedNonNutritionInfo,MappedNonNutritionInfo]) :-
	view([barcodeAtom,BarcodeAtom]),
	lookup_branded_food_by_barcode_atom(BarcodeAtom,FDC_ID,DESC),
	branded_food(FDC_ID,Brand_Owner,Gtin_Upc,Ingredients,Serving_Size,Serving_Size_Unit,Household_Serving_Fulltext,Branded_Food_Category,Data_Source,Modified_Date,Available_Date),
        prologify(DESC,ItemNamePrologified),
        prologifyRest(Brand_Owner,BrandNamePrologifiedRest),
        atomic_list_concat([ItemNamePrologified,BrandNamePrologifiedRest],'_',ProductIDDescriptive),
	get_all_for_barcode_atom(BarcodeAtom,[_FDC_ID,_DESC,NutritionSearchResults,Ingredients]),
	(   map_nutrition_info_for_barcode_atom(BarcodeAtom,TmpMappedNutritionInfo) ->
	    MappedNutritionInfo = TmpMappedNutritionInfo ;
	    MappedNutritionInfo = []),
	(   map_non_nutrition_info_for_barcode_atom([invFn(invFn(idFn(gourmetFDC,FDC_ID),barcodeFn(BarcodeAtom))),invCat(Branded_Food_Category),flpNameFn(ProductIDDescriptive),brandOwner(Brand_Owner),description(DESC),nutrition(NutritionSearchResults),ingredients(Ingredients),mappedNutritionInfo(MappedNutritionInfo)],TmpMappedNonNutritionInfo) ->
	    (	view(wtf),
		MappedNonNutritionInfo =  TmpMappedNonNutritionInfo) ;
	    (	view(motherfucker),
		MappedNonNutritionInfo = [])).

:- ensure_loaded('/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/scripts/gourmet/fdc_nutrition_to_nutritionix.pl').
