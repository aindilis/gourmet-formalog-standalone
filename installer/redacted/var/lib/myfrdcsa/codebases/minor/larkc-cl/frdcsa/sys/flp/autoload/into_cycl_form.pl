:- module(into_cycl_form,[decompound/3,into_cycl_form/2]).

cl_quote('CL:QUOTE'):-!.
cl_quote('\''). % '

upper_dash(N,NN):- atomic_list_concat(NL,'_',N),atomic_list_concat(NL,'-',NN).
harden_cycl_vars(G,G):- ground(G),!.
harden_cycl_vars(V,NN):- var(V),var_property(V,name(VN)),!,atom_concat('?VAR-',VN,N),upper_dash(N,NN).
harden_cycl_vars(V,NN):- var(V),!,format(atom(N),'?VAR~w',[V]),upper_dash(N,NN).
harden_cycl_vars(G,G):- \+ compound(G),!.
harden_cycl_vars(A,AA):- compound_name_arguments(A,F,AL),maplist(harden_cycl_vars,AL,AAL),compound_name_arguments(AA,F,AAL).


cycl_2:-fail.

%% (#$SecondFn 0 (#$MinuteFn 18 (#$HourFn 6 (#$DayFn 1 (#$MonthFn #$January (#$YearFn 3000))))))
%% ['SecondFn',S,['MinuteFn',Mi,['HourFn',H,['DayFn',D,['MonthFn',Mo,['YearFn',Y]]]]]]

month(1,'January').
month(2,'February').
month(3,'March').
month(4,'April').
month(5,'May').
month(6,'June').
month(7,'July').
month(8,'August').
month(9,'September').
month(10,'October').
month(11,'November').
month(12,'December').

month('1','January').
month('2','February').
month('3','March').
month('4','April').
month('5','May').
month('6','June').
month('7','July').
month('8','August').
month('9','September').
month('10','October').
month('11','November').
month('12','December').

%% into_cycl_form('[|]','TheList').
%% into_cycl_form('[]','TheEmptyList').
into_cycl_form(A,AA):- A = [Y-M-D,H:Mi:S],!,month(M,Mo),AA=['SecondFn',S,['MinuteFn',Mi,['HourFn',H,['DayFn',D,['MonthFn',Mo,['YearFn',Y]]]]]].
into_cycl_form(A,AA):- var(A),!,A=AA.
into_cycl_form(',','and'):- !.
into_cycl_form(';','or'):- !.
into_cycl_form(A,AA):- atomic(A),!,A=AA.
into_cycl_form((A:-B),'sentenceImplies'(BB,AA)):- cycl_2, !, into_cycl_form(A,AA),into_cycl_form(B,BB).
into_cycl_form((A:-B),'implies'(BB,AA)):- !, into_cycl_form(A,AA),into_cycl_form(B,BB).
into_cycl_form(M:P,AA):- \+ atomic(P),!,into_cycl_form(ist(M,P),AA).
into_cycl_form(WasList,['TheList'|Same]):- is_list(WasList),!,maplist(into_cycl_form,WasList,Same).  
%% into_cycl_form(WasList,Same):- is_list(WasList),!,maplist(into_cycl_form,WasList,Same).
into_cycl_form(A,AA):- A=..AL, maplist(into_cycl_form,AL,AA).

%% see https://github.com/TeamSPoon/CYC_JRTL_with_CommonLisp/blob/larkc/platform/site-lisp/cb-logicmoo/cb_prolog.lisp#L1340-L1360
	

unify_cycl_form(Binding,Binding):- (var(Binding);number(Binding)),!.
unify_cycl_form(string(B),string(B)):-!.
unify_cycl_form(Binding,BindingP):-atom(Binding),atom_concat('#$',BindingP,Binding),!.
unify_cycl_form(nart(B),nart(BB)):-unify_cycl_form(B,BB),!.
unify_cycl_form(nart(B),(BB)):-!,unify_cycl_form(B,BB),!.
%unify_cycl_form(string(B),List):-atomSplit(List,B),!.
unify_cycl_form(string(B),B):-!.
unify_cycl_form(string([]),""):-!.
unify_cycl_form(quote(B),BO):-!,unify_cycl_form(B,BO).
unify_cycl_form([A|L],Binding):-unify_cycl_formCons(A,L,Binding),!.
unify_cycl_form(Binding,Binding):-!.

unify_cycl_formCons(A,L,[A|L]):- (var(A);var(L);A=string(_);number(A)),!.
% unify_cycl_formCons('and-also',L,Binding):-unify_cycl_formS(L,LO), list_to_conj(LO,Binding),!.
% unify_cycl_formCons('eval',L,Binding):-unify_cycl_formS(L,LO), list_to_conj(LO,Binding),!.
% unify_cycl_formCons('#$and-also',L,Binding):-unify_cycl_formS(L,LO), list_to_conj(LO,Binding),!.
unify_cycl_formCons(A,L,Binding):-
	unify_cycl_form(A,AO),
	unify_cycl_formCons(A,AO,L,Binding).
unify_cycl_formCons(_A,AO,L,Binding):-
	atom(AO),!,
	unify_cycl_formS(L,LO),
	Binding=..[AO|LO],!.
unify_cycl_formCons(_A,AO,L,Binding):-
	unify_cycl_formS(L,LO),
	Binding=[AO|LO],!.

unify_cycl_formS(Binding,Binding):- (var(Binding);atom(Binding);number(Binding)),!.
unify_cycl_formS([],[]).
unify_cycl_formS([V,[L]|M],[LL|ML]):- nonvar(V), cl_quote(V),unify_cycl_formS(L,LL),unify_cycl_formS(M,ML).
unify_cycl_formS([A|L],[AA|LL]):-unify_cycl_form(A,AA),unify_cycl_formS(L,LL).

decompound(Mt,Prolog,Decompounded):-
	ISTPROLOG = ist(Mt,Prolog),
	term_variables(Prolog,PrologVars),
	into_cycl_form(ISTPROLOG,ISTFORM),
	harden_cycl_vars(PrologVars+ISTFORM,CycLVars+ISTLISP),
	ISTLISP = ['ist',HLMt,Decompounded].
