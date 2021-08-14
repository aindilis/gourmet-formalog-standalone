:- dynamic fodmap_diet/2.

%% to enable json_read/2
:- use_module(library(http/json)).

load_fodmap :-
	Dir = '/var/lib/myfrdcsa/codebases/minor/gourmet-formalog/special-diets/low-fodmap/sys/basket-20210508',
	directory_files(Dir,Files),
	member(File,Files),
	atom_concat(_Root,'.json',File),
	atomic_list_concat([Dir,File],'/',NewFile),
	view([file,NewFile]),
	open(NewFile, read, Stream),
	json_read(Stream, TmpObject),
	TmpObject = json(List),
	member(Object,List),
	Object = '='(Type,json(AttributeList)),
	ensureAsserted(fodmap_diet(Type,AttributeList)),
	fail.
	
load_fodmap :-
	true.

%% get_rec(Description,Ingredients,Instructions) :-
%% 	rec(Description,TmpIngredients,Instructions),
%% 	member(ing(A,B,Ingredient),TmpIngredients),
%% 	food(FDC_ID,_,TmpIngredient,_,_),
%% 	downcase_atom(Ingredient,DCIngredient),
%% 	downcase_atom(TmpIngredient,DCIngredient).


%%	remove ingredients, swap ingredients, add ingredients