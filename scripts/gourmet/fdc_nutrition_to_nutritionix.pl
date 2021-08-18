%% [invFn,invFn(idFn(gourmetFDC,FDC_ID),barcodeFn(BarcodeAtom)),invCat,Branded_Food_Category,flpNameFn,ProductIDDescriptive,brandOwner,Brand_Owner,description,DESC,nutrition,NutritionSearchResults,ingredients,Ingredients,mappedNutritionInfo,MappedNutritionInfo])

map_non_nutrition_info_for_barcode_atom(Arguments,MappedNonNutritionInfo) :-
	FDCNonNutrientNames = [invFn,brandOwner,description,ingredients],
	view([1]),
	argt(Arguments,invFn(invFn(idFn(gourmetFDC,FDC_ID),barcodeFn(BarcodeAtom)))),
	findall(NonNutritionItem,
		(
		 view([3]),
		 member(FDCNonNutrientName,FDCNonNutrientNames),
		 view([4]),
		 Query =.. [FDCNonNutrientName,Value],
		 argt(Arguments,Query),
		 view([fdcNonNutrientName,FDCNonNutrientName,value,Value]),
		 fdcMetadataToNutritionix(FDCNonNutrientName,NutritionixNonNutrientName),
		 view([nutritionixNonNutrientName,NutritionixNonNutrientName]),
		 NonNutritionItem =.. [NutritionixNonNutrientName,idFn(gourmetFDC,FDC_ID),Value]
		),
		MappedNonNutritionInfo).
	
fdcMetadataToNutritionix(description,item_name).
fdcMetadataToNutritionix(invFn,item_id).
fdcMetadataToNutritionix(brandOwner,brand_name).
fdcMetadataToNutritionix(ingredients,ingredient_statement).
fdcMetadataToNutritionix(unknown_record,brand_id).
fdcMetadataToNutritionix(unknown_record,updated_at).
fdcMetadataToNutritionix(unknown_record,serving_weight_grams).
fdcMetadataToNutritionix(unknown_record,item_description).
fdcMetadataToNutritionix(unknown_record,serving_size_qty).
fdcMetadataToNutritionix(unknown_record,serving_size_unit).
fdcMetadataToNutritionix(unknown_record,servings_per_container).


%% search_food_data_central('041196915051',[invFn,invFn(idFn(gourmetFDC,FDC_ID),barcodeFn(BarcodeAtom)),invCat,Branded_Food_Category,flpNameFn,ProductIDDescriptive,brandOwner,Brand_Owner,description,DESC,nutrition,NutritionSearchResults,ingredients,Ingredients,mappedNutritionInfo,MappedNutritionInfo])

conversionFactor(Item,Item,1.0).
conversionFactor(kilocalories,calories,1000.0).
conversionFactor(grams,milligrams,1000.0).

map_nutrition_info_for_barcode_atom(BarcodeAtom,MappedNutritionInfo) :-
	get_nutrition_for_barcode_atom(BarcodeAtom,[FDC_ID,DESC,FDCNutritionInfo]),
	view([FDC_ID,DESC,FDCNutritionInfo]),
	findall(nf(NutritionixNutrientName,idFn(gourmetFDC,FDC_ID),Amount),
		(
		 member(result(FDCNutrientID,FDCNutrientName,FDCAmount,_FDCNutrientUnitName),FDCNutritionInfo),
		 view(result([FDCNutrientID,FDCNutrientName,FDCAmount,_FDCNutrientUnitName])),
		 fdcNutritionToNutritionix(FDCNutrientName,FDCNutrientUnitName,NutritionixNutrientName,NutritionixUnitName),
		 conversionFactor(FDCNutrientUnitName,NutritionixUnitName,ConversionFactor),
		 (   nonvar(ConversionFactor) ->
		     (
		      view([conversionFactor,ConversionFactor]),
		      NutritionixAmount is FDCAmount * ConversionFactor,
		      Amount =.. [NutritionixUnitName,NutritionixAmount]
		     ) ;
		     Amount = unknown(_)
		 )
		),
		MappedNutritionInfo).

%% prolog_list('619542','CAVATAPPI',
%% 	    _prolog_list(result('1003','Protein','12.5','G'),
%% 			 result('1004','Total lipid (fat)','1.7o9','G'),
%% 			 result('1005','Carbohydrate, by difference','73.21','G'),
%% 			 result('1008','Energy','357','KCAL'),
%% 			 result('2000','Sugars, total including NLEA','3.57','G'),
%% 			 result('1079','Fiber, total dietary','3.6','G'),
%% 			 result('1087','Calcium, Ca','0','MG'),
%% 			 result('1089','Iron, Fe','3.21','MG'),
%% 			 result('1093','Sodium, Na','0','MG'),
%% 			 result('1104','Vitamin A, IU','0','IU'),
%% 			 result('1162','Vitamin C, total ascorbic acid','0','MG'),
%% 			 result('1253','Cholesterol','0','MG'),
%% 			 result('1257','Fatty acids, total trans','0','G'),
%% 			 result('1258','Fatty acids, total saturated','0','G')
%% 			)).

%% barcode(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),'041196915051').
%% nf(serving_weight_grams,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('239')).
%% nf(protein,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('6')).
%% updated_at(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('2017-01-24T07:13:14.000Z')).
%% nf(ingredient_statement,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown1('Chicken Broth, Cooked Meatballs (Pork, Beef, Water, Eggs, Textured Soy Protein [Soy Protein Concentrate, Caramel Color], Romano Cheese [Made from Sheep_SINGLEQUOTE_s Milk, Cultures, Salt, Enzymes], Bread Crumbs [Bleached Wheat Flour, Dextr\
%% ose, Salt, Yeast], Corn Syrup, Onion, Soy Protein Concentrate, Salt, Spice, Sodium Phosphate, Garlic Powder, Dried Parsley, Onion Powder, Natural Flavor), Carrots, Tubetti Pasta (Semolina Wheat, Egg Whites), Spinach. Contains Less than 2% of: Onions, Modified Food Starch, Salt, Chicken Fat, Carrot Puree, Corn Protein\
%%  (Hydrolyzed), Potassium Chloride, Onion Powder, Sugar, Yeast Extract, Spice, Garlic Powder, Soybean Oil, Natural Flavor, Beta Carotene (Color).')).
%% nf(serving_size_unit,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unit(cup)).
%% nf(vitamin_c_dv,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),percent('0')).
%% nf(calories_from_fat,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),calories('35')).
%% nf(calories,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),calories('120')).
%% nf(cholesterol,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),milligrams('10')).
%% nf(servings_per_container,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),servings('2')).
%% nf(dietary_fiber,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('1')).
%% nf(monounsaturated_fat,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('1.5')).
%% item_description(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('Italian-Style Wedding')).
%% nf(vitamin_a_dv,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),percent('25')).
%% nf(iron_dv,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),percent('4')).
%% nf(calcium_dv,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),percent('2')).
%% nf(polyunsaturated_fat,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('0')).
%% item_id(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('51c37b3c97c3e6d27282496f')).
%% nf(serving_size_qty,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),quantity('1')).
%% nf(sodium,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),milligrams('690')).
%% nf(total_carbohydrate,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('15')).
%% nf(sugars,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('2')).
%% item_name(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('Italian-Style Wedding Soup')).
%% brand_name(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('Progresso')).
%% nf(total_fat,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('4')).
%% brand_id(idFn(nutritionix,'51c37b3c97c3e6d27282496f'),unknown2('51db37b4176fe9790a898803')).
%% nf(trans_fatty_acid,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('0')).
%% nf(saturated_fat,idFn(nutritionix,'51c37b3c97c3e6d27282496f'),grams('1.5')).


%%%%%%


%% setof(Unit_Name,Unit_Name^nutrient(_,_,Unit_Name,_,_),Results),write_list(Results).
unit_name_mapping('G',grams).
unit_name_mapping('IU',unknown).
unit_name_mapping('KCAL',kilocalories).
unit_name_mapping(kJ,unknown).
unit_name_mapping('MG',milligrams).
unit_name_mapping('MG_ATE',unknown).
unit_name_mapping('SP_GR',unknown).
unit_name_mapping('UG',unknown).


%% NON NUTRIENT FACTS FDC

%% %% ?FDC_ID = '609852'.
%% %% ?BarcodeAtom = '041196915051'.
%% -- ?Branded_Food_Category = 'Prepared Soups'.
%% -- ?ProductIDDescriptive = 'progressoTraditionalItalianStyleWeddingSoup_GENERALMILLSSALESINC.'.
%% %% ?Brand_Owner = 'GENERAL MILLS SALES INC.'.
%% %% ?DESC = 'Progresso Traditional Italian-Style Wedding Soup'.
%% -- ?NutritionSearchResults = _prolog_list(result('1003','Protein','2.51','G'),result('1004','Total lipid (fat)','1.67','G'),result('1005','Carbohydrate, by difference','6.28','G'),result('2000','Sugars, total including NLEA','0.84','G'),result('1079','Fiber, total dietary','0.4','G'),result('1087','Calcium, Ca','8','MG'),result('1089','Iron, Fe','0.3','MG'),result('1092','Potassium, K','134','MG'),result('1093','Sodium, Na','289','MG'),result('1104','Vitamin A, IU','523','IU'),result('1162','Vitamin C, total ascorbic acid','0','MG'),result('1253','Cholesterol','4','MG'),result('1257','Fatty acids, total trans','0','G'),result('1258','Fatty acids, total saturated','0.63','G'),result('1292','Fatty acids, total monounsaturated','0.63','G'),result('1293','Fatty acids, total polyunsaturated','0','G')).
%% %% ?Ingredients = 'CHICKEN BROTH, COOKED TUBETTI PASTA (WATER, SEMOLINA WHEAT, EGG WHITE), FULLY COOKED MEATBALLS (PORK, BEEF, WATER, TEXTURED SOY PROTEIN CONCENTRATE, SOY PROTEIN CONCENTRATE, ROMANO CHEESE [PASTEURIZED PART-SKIM COW_SINGLEQUOTE_S MILK, CHEESE CULTURES, SALT, ENZYMES], BREAD CRUMBS [BLEACHED WHEAT FLOUR, DEXTROSE, SALT, YEAST], CORN SYRUP, ONIONS, SALT, SODIUM PHOSPHATE, SPICES, GARLIC POWDER, PARSLEY, NATURAL FLAVOR), CARROTS, SPINACH. CONTAINS LESS THAN 2% OF: ONIONS, MODIFIED FOOD STARCH, CORN PROTEIN (HYDROLYZED), SALT, CARROT PUREE, POTASSIUM CHLORIDE, ONION POWDER, SUGAR, TOMATO EXTRACT, SPICE, GARLIC POWDER, MALTODEXTRIN, FLAVORING, NATURAL FLAVOR, BETA CAROTENE (COLOR).'.
%% --- ?MappedNutritionInfo = _prolog_list(nf(protein,idFn(gourmetFDC,'609852'),grams('2.51')),nf(total_fat,idFn(gourmetFDC,'609852'),grams('1.67')),nf(total_carbohydrate,idFn(gourmetFDC,'609852'),grams('6.28')),nf(sugars,idFn(gourmetFDC,'609852'),grams('0.84')),nf(dietary_fiber,idFn(gourmetFDC,'609852'),grams('0.4')),nf(sodium,idFn(gourmetFDC,'609852'),milligrams('289')),nf(cholesterol,idFn(gourmetFDC,'609852'),milligrams('4')),nf(trans_fatty_acid,idFn(gourmetFDC,'609852'),grams('0')),nf(saturated_fat,idFn(gourmetFDC,'609852'),grams('0.63')),nf(monounsaturated_fat,idFn(gourmetFDC,'609852'),grams('0.63')),nf(polyunsaturated_fat,idFn(gourmetFDC,'609852'),grams('0'))).


%% NON NUTRIENT FACTS NUTRITIONIX

%% %% nf(serving_size_qty,idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),quantity('1')).
%% %% brand_id(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('51db381b176fe9790a89b570')).
%% %% brand_name(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('Hungry-Man')).
%% %% nf(servings_per_container,idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),servings('1')).
%% %% nf(serving_size_unit,idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unit(package)).
%% %% nf(serving_weight_grams,idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),grams('454')).
%% %% updated_at(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('2020-09-03T14:49:53.000Z')).
%% %% item_id(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('51d2fd12cc9bff111580e7b8')).
%% %% item_name(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('Boneless Fried Chicken')).
%% %% nf(ingredient_statement,idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown1('Boneless Fried Chicken Patties (Ground Chicken, Enriched Flour [Wheat Flour, Niacin, Reduced Iron, Thiamine Mononitrate, Riboflavin, Folic Acid], Water, Partially Hydrogenated Soybean Oil with TBHQ and Citric Acid as Preservatives, Soy Protein Concentrate, Isolated Oat Product, Salt, Sodium Phosphate, Monosodium Glutamate, Dextrose, Spice Extract), Mashed Potatoes (Water, Reconstituted Potatoes, [Mono and Diglycerides, Sodium Acid Pyrophosphate, Citric Acid], Heavy Cream, Butter [Cream, Salt], Salt, Margarine [Partially Hydrogenated Soybean Oil with TBHQ and Citric Acid as Preservatives, Water, Mono and Diglycerides {BHT, Citric Acid}, Beta Carotene for Color {Corn Oil, Tocopherol} Vitamin A Palmitate], Potato Flavor [Potatoes, Water, Buttermilk, Butter Oil, Salt, Natural Flavors, Soy Lecithin, Calcium Chloride, Tocopherol, Enzyme]), Corn, Brownie (Sugar, Water, Wheat Flour, Partially Hydrogenated Soybean Oil with TBHQ and Citric Acid as Preservatives, Cocoa, Eggs, Margarine [Partially Hydrogenated Soybean Oil and/or Soybean Oils, Water, Mono and Diglycerides, Beta Carotene for Color, May Also Contain Vitamin A Palmitate, Salt, Whey, Soy Lecithin, Natural Flavor], Acacia and Xanthan Gums, Sodium Bicarbonate [Hydrogenated Cottonseed Oil], Salt, Natural and Artificial Vanilla Flavor [Water, Propylene Glycol, Ethanol, Caramel Color]), Sauce (Water, Sugar, Margarine [Soybean Oil, Partially Hydrogenated Soybean Oil, Water, Salt, Whey, Soy Lecithin, Mono and Diglycerides, Natural Flavor, Beta Carotene {Color}, Vitamin A Palmitate], Salt, Partially Hydrogenated Soybean Oil with TBHQ and Citric Acid as Preservatives).')).
%% %% item_description(idFn(nutritionix,'51d2fd12cc9bff111580e7b8'),unknown2('Boneless')).



%%%%%%%%%%%%%%%



%% setof([Unit_Name,Pred],ID^(nf(Unit_Name,idFn(nutritionix,ID),Value),Value =.. [Pred|Rest]),Names),write_list(Names).

%% findall(fdcNutritionToNutritionix(Name,Converted_Name,arg3,arg4),(nutrient(Id,Name,Unit_Name,Nutrient_Nbr,Rank),unit_name_mapping(Unit_Name,Converted_Name)),Results),write_list(Results).

%% get_nutrition_for_barcode_atom('041250025979',X).

%% fdcNutritionToNutritionix('Total lipid (fat)',grams,total_fat,grams).
%% %% fdcNutritionToNutritionix('Total fat (NLEA)',grams,total_fat,grams).
%% fdcNutritionToNutritionix('Fatty acids, total saturated',grams,saturated_fat,grams).
%% fdcNutritionToNutritionix('Cholesterol',milligrams,cholesterol,milligrams).
%% fdcNutritionToNutritionix('Sodium',milligrams,sodium,milligrams).
%% fdcNutritionToNutritionix('Carbohydrate, by difference',grams,total_carbohydrate,grams).
%% %% fdcNutritionToNutritionix('Carbohydrate, by summation',grams,total_carbohydrate,grams).
%% fdcNutritionToNutritionix('Fiber, total dietary',grams,dietary_fiber,grams).
%% fdcNutritionToNutritionix('Energy',kilocalories,calories,calories).
%% %% serving_weight_grams


%% %% [calcium_dv,percent].
%% %% [calories,calories].
%% ?? [calories_from_fat,calories].
%% %% [cholesterol,milligrams].
%% %% [dietary_fiber,grams].
%% -- [ingredient_statement,unknown1].
%% %% [iron_dv,percent].
%% %% [monounsaturated_fat,grams].
%% %% [polyunsaturated_fat,grams].
%% %% [protein,grams].
%% %% [saturated_fat,grams].
%% -- [serving_size_qty,quantity].
%% -- [serving_size_unit,unit].
%% -- [servings_per_container,servings].
%% -- [serving_weight_grams,grams].
%% %% [sodium,milligrams].
%% %% [sugars,grams].
%% ?? [total_carbohydrate,grams].
%% %% [total_fat,grams].
%% %% [trans_fatty_acid,grams].
%% %% [vitamin_a_dv,percent].
%% %% [vitamin_c_dv,percent].

fdcNutritionToNutritionix('Nitrogen',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Protein',grams,protein,grams).
fdcNutritionToNutritionix('Total lipid (fat)',grams,total_fat,grams).
fdcNutritionToNutritionix('Carbohydrate, by difference',grams,total_carbohydrate,grams).
fdcNutritionToNutritionix('Ash',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Energy',kilocalories,calories,calories).
fdcNutritionToNutritionix('Starch',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sucrose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Glucose (dextrose)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fructose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lactose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Maltose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Alcohol, ethyl',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Specific Gravity',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Acetic acid',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lactic acid',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Carbohydrate, by summation',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Water',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sorbitol',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Caffeine',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Theobromine',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Energy',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sugars, Total NLEA',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Carbohydrate, other',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Galactose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Xylitol',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fiber, total dietary',grams,dietary_fiber,grams).
fdcNutritionToNutritionix('Ribose',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fiber, soluble',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fiber, insoluble',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Total fat (NLEA)',grams,total_fat,grams).
fdcNutritionToNutritionix('Total sugar alcohols',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Calcium, Ca',milligrams,calcium_dv,percent).
fdcNutritionToNutritionix('Chlorine, Cl',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Iron, Fe',milligrams,iron_dv,percent).
fdcNutritionToNutritionix('Magnesium, Mg',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phosphorus, P',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Potassium, K',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sodium, Na',milligrams,sodium,milligrams).
fdcNutritionToNutritionix('Sulfur, S',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Zinc, Zn',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Chromium, Cr',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cobalt, Co',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Copper, Cu',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fluoride, F',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Iodine, I',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Manganese, Mn',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Molybdenum, Mo',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Selenium, Se',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin A, IU',unknown,vitamin_a_dv,percent).
fdcNutritionToNutritionix('Retinol',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin A, RAE',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Carotene, beta',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Carotene, alpha',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin E (alpha-tocopherol)',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin D (D2 + D3), International Units',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin D2 (ergocalciferol)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin D3 (cholecalciferol)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('25-hydroxycholecalciferol',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin D (D2 + D3)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phytoene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phytofluene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Zeaxanthin',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cryptoxanthin, beta',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lutein',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lycopene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lutein + zeaxanthin',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin E (label entry primarily)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocopherol, beta',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocopherol, gamma',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocopherol, delta',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocotrienol, alpha',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocotrienol, beta',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocotrienol, gamma',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tocotrienol, delta',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Boron, B',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Nickel, Ni',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin E',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('cis-beta-Carotene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('cis-Lycopene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('cis-Lutein/Zeaxanthin',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin C, total ascorbic acid',milligrams,vitamin_c_dv,percent).
fdcNutritionToNutritionix('Thiamin',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Riboflavin',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Niacin',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Pantothenic acid',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin B-6',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Biotin',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Folate, total',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin B-12',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, total',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Inositol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin K (Menaquinone-4)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin K (Dihydrophylloquinone)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin K (phylloquinone)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Folic acid',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Folate, food',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('5-methyl tetrahydrofolate (5-MTHF)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Folate, DFE',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('10-Formyl folic acid (10HCOFA)',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('5-Formyltetrahydrofolic acid (5-HCOH4',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, free',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, from phosphocholine',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, from phosphotidyl choline',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, from glycerophosphocholine',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Betaine',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Choline, from sphingomyelin',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tryptophan',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Threonine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Isoleucine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Leucine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Lysine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Methionine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cystine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phenylalanine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Tyrosine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Valine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Arginine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Histidine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Alanine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Aspartic acid',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Glutamic acid',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Glycine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Proline',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Serine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Hydroxyproline',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cysteine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Glutamine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Taurine',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sugars, added',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin E, added',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Vitamin B-12, added',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cholesterol',milligrams,cholesterol,milligrams).
fdcNutritionToNutritionix('Fatty acids, total trans',grams,trans_fatty_acid,grams).
fdcNutritionToNutritionix('Fatty acids, total saturated',grams,saturated_fat,grams).
fdcNutritionToNutritionix('4:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('6:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('8:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('10:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('12:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('14:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('16:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:4',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:6 n-3 (DHA)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('14:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('16:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:4',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:5 n-3 (EPA)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:5 n-3 (DPA)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('14:1 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phytosterols',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Stigmasterol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Campesterol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Brassicasterol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Beta-sitosterol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Campestanol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fatty acids, total monounsaturated',grams,monounsaturated_fat,grams).
fdcNutritionToNutritionix('Fatty acids, total polyunsaturated',grams,polyunsaturated_fat,grams).
fdcNutritionToNutritionix('Beta-sitostanol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Delta-5-avenasterol',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Phytosterols, other',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('15:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('17:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('24:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('16:1 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:1 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:1 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 t not further defined',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 i',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 t,t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 CLAs',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('24:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:2 n-6 c,c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('16:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 n-6 c,c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3 n-6 c,c,c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('17:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:3',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fatty acids, total trans-monoenoic',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fatty acids, total trans-dienoic',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Fatty acids, total trans-polyenoic',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('13:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('15:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:2',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('11:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Epigallocatechin-3-gallate',milligrams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Inulin',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3 n-3 c,c,c (ALA)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:3 n-3',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:3 n-6',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:4 n-6',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3i',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('21:5',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:4',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:1-11 t (18:1t n-7)',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:3 n-9',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Sugars, total including NLEA',grams,sugars,grams).
fdcNutritionToNutritionix('5:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('7:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('9:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('21:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('23:0',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('12:1',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('14:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('17:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:1 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:1 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:1 n-9',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:1 n-11',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:2 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('18:3 t',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:3 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:3',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:4 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:5 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:5 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('22:6 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('20:2 c',grams,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('trans-beta-Carotene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('trans-Lycopene',unknown,unknown_nutrient,unknown_unit_name).
fdcNutritionToNutritionix('Cryptoxanthin, alpha',unknown,unknown_nutrient,unknown_unit_name).
