%% alexaSkillName(flp,'life planner').
%% alexaSkillName(flp,'free life planner').
alexaSkillName(flp,'david').

currentAgent(andrewDougherty).
currentSpeaker(andrewDougherty).

currentWSMContext(fictional).
%% currentWSMContext(real).

getContextFromWSMContextTmp(WSMContext,Context) :-
	atom_concat('Org::Cyc::WSMContext::',WSMContext,Context).

:-	currentWSMContext(WSMContext),
	getContextFromWSMContextTmp(WSMContext,Context).
	%% formalog_load_contexts('Agent1','Yaswi1',[Context,'Org::Cyc::BaseKB']).

hasProperty(fictional,fictional).
hasProperty(real,nonfictional).
