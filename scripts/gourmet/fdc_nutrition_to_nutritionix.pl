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
