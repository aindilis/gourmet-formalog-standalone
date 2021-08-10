%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURATION

hasDialogEntry('change user to <AGENT>').
dialogInterfaceQuery(Entry)  --> ([change];[set]),([];[current]),[user],([];[to]),grabber(Agent,agent),
	{Entry = query(setByRetractingAllAndAsserting(currentAgent(Agent)))}.

hasDialogEntry('change speaker to <AGENT>').
dialogInterfaceQuery(Entry)  --> ([change];[set]),([];[current]),[speaker],([];[to]),grabber(Agent,agent),
	{Entry = query(setByRetractingAllAndAsserting(currentSpeaker(Agent)))}.

hasDialogEntry('change context to <CONTEXT>').
dialogInterfaceQuery(Entry)  --> ([change];[set]),([];[current]),[context],([];[to]),grabber(Context,wsmContext),
	{Entry = query(setByRetractingAllAndAsserting(currentWSMContext(Context)))}.

hasDialogEntry('change capsule to <CAPSULE>').
dialogInterfaceQuery(Entry)  --> ([change];[set]),([];[current]),([capsule];[planning,capsule];[domain];[planning,domain]),([];[to]),grabber(PlanningCapsule,planningCapsule),
	{Entry = query(setByRetractingAllAndAsserting(currentPlanningCapsule(PlanningCapsule)))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DATES

hasDialogEntry('when is my next appointment').
dialogInterfaceQuery(Entry)  --> [when,is],([my];[the];[]),[next,appointment],
	{currentAgent(CurrentAgent),
	 Entry = query(whenIsAgent1NextAppointmentWithAgent2(CurrentAgent,_,Date))}.

hasDialogEntry('when is the next appointment for <AGENT>').
dialogInterfaceQuery(Entry)  --> [when,is,the,next,appointment,for],grabber(Agent,agent),
	{Entry = query(whenIsAgent1NextAppointmentWithAgent2(Agent,_,Date))}.

hasDialogEntry('how many days until <DATE>').
dialogInterfaceQuery(Entry)  --> [how,many,days,until],grabber(Date,date),
	{getCurrentDateTime([CurrentDate,_]),
	 Entry = query(daysUntilDate([CurrentDate],Date,Days))}.

desired(hasDialogEntry('cancel appointment with <AGENT> on <DATE>')).

desired(hasDialogEntry('we need to reschedule appointment with <AGENT> on <DATE> (to <DATE>)?')).

desired(hasDialogEntry('reschedule appointment with <AGENT> on <DATE> to <DATE>')).

desired(hasDialogEntry('who''s coming at time T')).
desired(hasDialogEntry('what''s mondays schedule')).
desired(hasDialogEntry('who''s coming monday')).
desired(hasDialogEntry('who else is coming monday')).
desired(hasDialogEntry('no one is coming this morning')).
desired(hasDialogEntry('is the nurse the only one coming today')).
desired(hasDialogEntry('what appointments are tomorrow')).
desired(hasDialogEntry('is there anything in the morning tomorrow')).
desired(hasDialogEntry('what do we need to take with us when taking the patient in the car')).
desired(hasDialogEntry('did we pay the water bill')).
desired(hasDialogEntry('when does the nurse come next')).
desired(hasDialogEntry('when was the last time the nurse came')).
desired(hasDialogEntry('can I sleep in')).
desired(hasDialogEntry('do I have anything( scheduled)? (in the (morning|afternoon|evening)|at night)')).
desired(hasDialogEntry('when is (my|the) next appointment with Person')).

desired(hasDialogEntry('how much did we spend on X this past month')).
desired(hasDialogEntry('how many calories did I have today')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROFILES

hasDialogEntry('I like <THING>').
dialogInterfaceQuery(Entry)  --> ([i] ; ['I']),[like],grabber(Thing,thing),
	{currentAgent(CurrentAgent),
	 getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,likes(CurrentAgent,Thing)))}.

hasDialogEntry('I (dislike|don''t like) <THING>').
dialogInterfaceQuery(Entry)  --> ([i] ; ['I']),([dislike] ; ['don''t',like] ; [do,not,like]), grabber(Thing,thing),
	{currentAgent(CurrentAgent),
	 getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,neg(likes(CurrentAgent,Thing))))}.


hasDialogEntry('<AGENT> likes <THING>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),[likes],grabber(Thing,food),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,likes(Agent,Thing)))}.

hasDialogEntry('<AGENT> (dislike|don''t like) <THING>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent), ([dislikes] ; ['doesn''t',like] ; [do,not,like]), grabber(Thing,food),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,neg(likes(Agent,Thing))))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUDIENCE

hasDialogEntry('call <AGENT> about <SUBJECT>').
dialogInterfaceQuery(Entry)  --> [call],grabber(Agent,agent),([about] ; [to]),oneOrMore(token,Tokens),
	{currentAgent(CurrentAgent),
	 Entry = execute(call(CurrentAgent,Agent,about(Tokens)))}.

%% hasDialogEntry('ask <AGENT> <QUESTION>').
%% dialogInterfaceQuery(Entry)  --> [ask],grabber(Agent,agent),oneOrMore(token,TokenizedQuestion),
%% 	{Entry = assert(atTime(DateTime,ask(Agent,question(TokenizedQuestion))))}.

hasDialogEntry('tell <AGENT> <STATEMENT>').
dialogInterfaceQuery(Entry)  --> ([to];[two];[too];[]),[tell],grabber(Agent,agent),oneOrMore(token,TokenizedStatement),
	{ currentAgent(CurrentAgent),
	  Entry = query(tellAgent(CurrentAgent,Agent,TokenizedStatement))}.

hasDialogEntry('ask <AGENT> <STATEMENT>').
dialogInterfaceQuery(Entry)  --> [ask],grabber(Agent,agent),oneOrMore(token,TokenizedStatement),
	{ currentAgent(CurrentAgent),
	  Entry = query(askAgent(CurrentAgent,Agent,TokenizedStatement))}.

hasDialogEntry('summon <AGENT>').
dialogInterfaceQuery(Entry)  --> ([to];[two];[too];[]),([some] ; [sum] ; [summon] ; [someone] ; [something] ; [seven] ; ['7'] ; (([some];[sum]),([and];[an]))),grabber(Agent,agent),
	{ Entry = query(summon(Agent)) }.

summon(Agent) :-
	(   (	Agent = redacted) ->
	    (	Message = 'Please come to the main area, redacted') ;
	    (	Message = 'Please come to the main area')),
	tell(Agent,[Message]).

hasDialogEntry('check on <AGENT>').
dialogInterfaceQuery(Entry)  --> ([check]),([on]),grabber(Agent,agent),
	{ Entry = query(checkOn(Agent)) }.

checkOn(Agent) :-
	tell(Agent,['Are you okay - ring twice for yes, once for no']).

%% hasDialogEntry('what questions are pending for <AGENT>').
%% dialogInterfaceQuery(Entry)  --> [ask],grabber(Agent,agent),oneOrMore(token,TokenizedQuestion),
%% 	{currentAgent(CurrentAgent),
%% 	 Entry = assert(atTime(DateTime,ask(Agent,question(TokenizedQuestion))))}.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FINANCIAL DECISION SUPPORT SYSTEM

hasDialogEntry('<AGENT1> loaned <AGENT> <DOLLAR_AMOUNT>').
dialogInterfaceQuery(Entry)  --> grabber(Agent1,agent),[loaned],grabber(Agent2,agent),dollarAmount(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,loaned(Agent1,Agent2,dollars(N))))}.

hasDialogEntry('print out bank statement').
dialogInterfaceQuery(Entry)  --> [print,out,bank,statement],
	{Entry = query(printBankStatement(redactedCheckingAccount))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AKAHIGE

hasDialogEntry('<AGENT>''s eyes are stinging').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),[eyes,are,stinging],
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasSymptom(Agent,eyesAreStinging)))}.

hasDialogEntry('<AGENT> (aspirated|coughed|choked|...').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([has];[had];[have];[head];[feels];[]),adt,grabber(Symptom,symptom),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasSymptom(Agent,Symptom)))}.

hasDialogEntry('<AGENT> (is|has|had|feels) <CONDITION>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([is];[has];[had];[is,having];[has,had];[feels]),grabber(Condition,condition),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasCondition(Agent,Condition)))}.

hasDialogEntry('<AGENT>''s pain is at <NUMBER>').
hasDialogEntry('<AGENT>''s pain is a <NUMBER>').
hasDialogEntry('<AGENT>''s pain is at a <NUMBER>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),[pain,is],([a] ; [at,a] ; [at]),number(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,painLevel(Agent,N)))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GOURMET

hasDialogEntry('<AGENT> drank <DRINK>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([drank];[drink];[drinks]),adt,grabber(Drink,drink),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,drink(Agent,Drink)))}.

%% hasDialogEntry('<AGENT> drank <DRINK>').
%% dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([drank];[drink]),oneOrMore(token,Drink),
%% 	{getCurrentDateTime(DateTime),
%% 	 Entry = assert(atTime(DateTime,drink(Agent,Drink)))}.

%% hasDialogEntry('<AGENT> ate>').
%% dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([ate] ; ['8'] ; [eight]),
%% 	{getCurrentDateTime(DateTime),
%% 	 Entry = assert(atTime(DateTime,ate(Agent)))}.

hasDialogEntry('<AGENT> ate <FOOD>').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([ate] ; ['8'] ; [eight]; [eat]),(grabber(Object,food) ; grabber(Object,foodType)),([today];[]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,ate(Agent,Object)))}.

hasDialogEntry('when will <AGENT> be hungry next').
dialogInterfaceQuery(Entry)  --> [when,will],grabber(Agent,agent),[be,hungry],([] ; [next]),
	{getCurrentDateTime(DateTime),
	 Entry = query(predict(next(DateTime,atTime(DateTime,isHungry(Agent)))))}.

desired(hasDialogEntry('how hungry will <AGENT> likely be at time T')).
desired(hasDialogEntry('is <AGENT> likely to be hungry now')).
desired(hasDialogEntry('I used up the last of the butternut squash soup')).
desired(hasDialogEntry('we''re all? out of butternut squash soup')).
desired(hasDialogEntry('reorder butternut squash soup')).
desired(hasDialogEntry('we are low on paper towels')).
desired(hasDialogEntry('we need more butternut squash soup')).
desired(hasDialogEntry('we ran out of butternut squash soup')).
desired(hasDialogEntry('get butternut squash soup')).
desired(hasDialogEntry('buy some? butternut squash soup')).
desired(hasDialogEntry('order some? butternut squash soup')).
desired(hasDialogEntry('we used up half of the milk')).
desired(hasDialogEntry('there isn''t a lot of milk left')).
desired(hasDialogEntry('we have an extra bottle of milk')).
desired(hasDialogEntry('we have tons of pasta')).
desired(hasDialogEntry('we need pasta')).
desired(hasDialogEntry('how much pasta is there')).
desired(hasDialogEntry('do we have any pop tarts left?')).
desired(hasDialogEntry('are there any pop tarts left?')).
desired(hasDialogEntry('where can I buy pop tarts?')).
desired(hasDialogEntry('who has the cheapest price on pop tarts?')).
desired(hasDialogEntry('who sells pop tarts the cheapest?')).

%% Questions

desired(hasDialogEntry('list all the food we have in the pantry')).
desired(hasDialogEntry('list all the food we have on the top shelf of the pantry')).

desired(hasDialogEntry('what baking ingredients do we have')).  %% literal.  i.e. ans: flower sugar
desired(hasDialogEntry('what ingredietns are required for recipe R')).
desired(hasDialogEntry('what ingredients do we still need to get to be able to make recipe R')).

desired(hasDialogEntry('...steps for walking through the cooking process')).

desired(hasDialogEntry('how many fresh vegetables do we have')).
desired(hasDialogEntry('when were the fresh vegetables purchased')).
desired(hasDialogEntry('when was the brocholi purchased')).
desired(hasDialogEntry('is the brocholi still good')).
desired(hasDialogEntry('what recipes can we make with the ingredients we have')).
desired(hasDialogEntry('')).

desired(hasDialogEntry('compare the price of a restaurant''s chicken wrap with the price of the ingredients prorated for one unit of recipe R, and how long do they take to be procured respectively')).

desired(hasDialogEntry('is it worth my time to make this or should we go to restaurant')).
desired(hasDialogEntry('program it with per hour rate).  keep in mind that)')).

%% Commands
desired(hasDialogEntry('start cooking timer')).

desired(hasDialogEntry('start walking me through recipe R')).
desired(hasDialogEntry('what is the next recipe step')).
desired(hasDialogEntry('how many teaspoons are in a tablespoon')).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO-TODO-LIST

hasDialogEntry('add to todo list <TASK>').
dialogInterfaceQuery(Entry)  --> [add,to],([to,do] ; [todo]),[list], oneOrMore(token,Tokens),
 	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,alexaToDoListTask(Tokens)))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INVENTORY MANAGER

hasDialogEntry('we''re out of <PRODUCT-TYPE>').
dialogInterfaceQuery(Entry)  --> (dt ; []),grabber(Location,location),([is,out,of];[has,no];[ran,out,of]),grabber(Product,product),
 	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasInventory(Location,Product,0)))}.

hasDialogEntry('we''re out of <PRODUCT-TYPE>').
%% we're out of | we are out of | there is no | reorder | we need more (of)? | we need to get (some)? | let''s get (a|the|(some)?)
dialogInterfaceQuery(Entry)  --> ([we,are];[we,'',re]),[out,of],grabber(Object,object),
 	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,outOfStock(townhome,Object)))}.

hasDialogEntry('add to shopping list <TASK>').
dialogInterfaceQuery(Entry)  --> [add,to],([to,do] ; [todo]),[list], oneOrMore(token,Tokens),
 	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,alexaToDoListTask(Tokens)))}.


hasDialogEntry('how many units do we have of <PRODUCT-TYPE>').
dialogInterfaceQuery(Entry)  --> ([how,many],grabber(Product,product),[are,in],grabber(Location,location)),
 	{getCurrentDateTime(DateTime),
	 Entry = query(atTimeQuery(DateTime,hasInventory(Location,Product,Quantity)))}.


hasDialogEntry('how many units do we have of <PRODUCT-TYPE>').
dialogInterfaceQuery(Entry)  --> (([how,many,units,do,we,have,of],grabber(Object,object)) ; ([how,many],grabber(Object,object),[do,we,have])),
 	{getCurrentDateTime(DateTime),
	 Entry = query(atTimeQuery(DateTime,hasInventory(townhome,Object,Units)))}.

hasDialogEntry('we have <COUNT> units of <PRODUCT-TYPE>').
dialogInterfaceQuery(Entry)  --> [we,have],number(N),[units,of],grabber(Object,object),
 	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasInventory(townhome,Object,N)))}.

hasDialogEntry('at time T1, I saw object X at location Y').
dialogInterfaceQuery(Entry)  --> (([at],[Time]) ; ([at,time],[Time])),([i] ; ['I']),[saw],dt,grabber(Object,object),([at]; [in]),dt,grabber(Location,location),
 	{integer(Time),Entry = assert(atTime(Time,location(Object,Location)))}.

%% hasDialogEntry('at time T1 I saw that object X was at location Y').
%% dialogInterfaceQuery(Entry)  --> (['at'] ; ['at','time']),[Time],([] ; ([i,'saw'],dt)),grabber(Object,object),(['at'] ; (['in'],dt)),grabber(Location,location),
%% 	{integer(Time),currentAgent(Agent),Entry = assert(atTime(Time,saw(Agent,location(Object,Location))))}.

hasDialogEntry('where is the object X').
dialogInterfaceQuery(Entry)  --> [where,is],dt,grabber(Object,object),
	{getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,location(Object,X))),view([entry,Entry])}.
%% factor in to try to informatively give the default location if none is known etc


hasDialogEntry('at time T1, where was object X').
dialogInterfaceQuery(Entry)  --> ([at] ; [at,time]),[Time],[where,was],dt,grabber(Symbol,object),
 	{integer(Time),Entry = query(atTimeQuery(Time,location(Symbol,X)))}.

hasDialogEntry('in plan case P1, if it is known where object X should be at time T3 in the future, please tell me.').

hasDialogEntry('the last known location of object X is Y').
dialogInterfaceQuery(Entry)  --> ([i] ; ['I']),[last,saw],dt,grabber(Object,object),([at] ; [in]),dt,grabber(Location,location),
	{getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,location(Object,Location)))}.
%% test('I last saw the bluetooth keyboard in the kitchen',assert(atTime(_G9870, location(_G9873, _G9874)))).

hasDialogEntry('the <OBJECT> is in the <LOCATION>').
dialogInterfaceQuery(Entry)  --> dt,grabber(Object,object),[is,in],dt,grabber(Location,location),
	{getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,location(Object,Location)))}.
%% test('The bluetooth keyboard is in the kitchen',_).

hasDialogEntry('the default location of object X is Y').
dialogInterfaceQuery(Entry)  --> dt,[default,location,of],dt,grabber(Object,object),[is],dt,grabber(Location,location),
	{getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,byDefault(location(Object,Location))))}.

hasDialogEntry('what is the default location of object X').
dialogInterfaceQuery(Entry)  --> [what,is],dt,[default,location,of],dt,grabber(Object,object),
	{Entry = query(atTimeQuery(DateTime,byDefault(location(Object,Location))))}.

desired(hasDialogEntry('the default location of object X was changed at time T4')).

desired(hasDialogEntry('it is unknown where object X was at time t5')).
desired(hasDialogEntry('object X was purchased at time t6')).
desired(hasDialogEntry('object X was sold, consumed or destroyed at time t7')).
desired(hasDialogEntry('there are 3 copies of object X in stock, in various conditions - c1, c2 and c3')).
desired(hasDialogEntry('object X may have been at location L sometime around duration T8 - T9')).
desired(hasDialogEntry('we''ve run out of object X as of now')).
desired(hasDialogEntry('consumable X is expected to be fully consumed by time T')).
desired(hasDialogEntry('condition C holds at time T')).
desired(hasDialogEntry('object X is not where I left it')).
desired(hasDialogEntry('I can''t find object X')).
desired(hasDialogEntry('object X has been lost since approximately time T')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DISCIPLE

desired(hasDialogEntry('start procedure <NAME>')).
desired(hasDialogEntry('next step')).
desired(hasDialogEntry('repeat previous step')).
desired(hasDialogEntry('skip this step')).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CHORES

dialogInterfaceQuery(Entry)  --> (([i] ; ['I']) ; ['are']),([vacuumed] ; [vacuum]),
	{getCurrentDateTime(DateTime),
	 currentAgent(Agent),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(vacuuming))))}.

dialogInterfaceQuery(Entry)  --> (([i] ; ['I']) ; ['are']),[did,the,dishes],
	{getCurrentDateTime(DateTime),
	 currentAgent(Agent),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(washTheDishes))))}.

hasDialogEntry('<AGENT> brushed').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([brushed] ; [brush]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(toothBrushing))))}.

dialogInterfaceQuery(Entry)  --> (([i] ; ['I']) ; ['are']),[did],([the];[]),([kitty];[cat];[]),[litter],([box];[]),
	{getCurrentDateTime(DateTime),
	 currentAgent(Agent),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(changeLitterBox))))}.

dialogInterfaceQuery(Entry)  --> (([i] ; ['I']) ; ['are']),([did];[do]),([the];[]),([laundry]),
	{getCurrentDateTime(DateTime),
	 currentAgent(Agent),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(doTheLaundry))))}.

dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),grabber(Chore,chore),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(Chore))))}.

hasDialogEntry('<AGENT> did her exercises (just)? now').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([did];[completed];[has,done];[has,finished];[has,completed]),([her];[his];[their];[its];[]),([daily];[current];[]),([exercises];[workout]),
	{getCurrentDateTime(DateTime),
	 currentAgent(Agent),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(exercises))))}.

hasDialogEntry('<AGENT> worked out (now?)').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),[worked,out],([];[now];[just,now]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,completed(Agent,choreFn(exercises))))}.


%% Doors

%% Windows

hasDialogEntry('the kitchen window is (open|closed)').
dialogInterfaceQuery(Entry)  --> dt,grabber(Openable,openable),([is];[are]),grabber(OpenableState,openableState),
	{getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,hasState(Openable,OpenableState)))}.

%% hasDialogEntry('is the kitchen window (open|closed)').
%% dialogInterfaceQuery(Entry)  --> [is],dt,grabber(Openable,window),grabber(OpenableState,windowState),
%% 	{getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,hasState(Openable,OpenableState)))}.

hasDialogEntry('is the <OPENABLE> <OPENABLESTATE>').
dialogInterfaceQuery(Entry)  --> ([is] ; [are]),dt,grabber(Openable,openable),grabber(OpenableState,openableState),
	{(getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,hasState(Openable,Result))))}.

hasDialogEntry('is the kitchen window open or closed').
dialogInterfaceQuery(Entry)  --> ([is] ; [are]),dt,grabber(Openable,openable),[open,or,closed],
	{(getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,hasState(Openable,Result))))}.

hasDialogEntry('which windows are open').
dialogInterfaceQuery(Entry)  --> [which,windows,are,open],
	{Entry = query(listOpenWindows(Openables))}.

listOpenWindows(OpenOpenables) :-
	getCurrentDateTime(DateTime),
	findall(Openable,isa(Openable,openable),Openables),
	findall([Openable,State],(member(Openable,Openables),atTimeQuery(DateTime,hasState(Openable,State))),OpenableStates),
	findall(Openable,member([Openable,open],OpenableStates),OpenOpenables).


%% Devices

hasDialogEntry('the (oven|stove burners?) (is|are) (on|off)').
dialogInterfaceQuery(Entry)  --> dt,grabber(Device,device),([is];[are]),grabber(DeviceState,deviceState),
	{getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,hasState(Device,DeviceState)))}.

hasDialogEntry('(is|are) the? (oven|stove burners?) on or off').
dialogInterfaceQuery(Entry)  --> ([is] ; [are]),dt,grabber(Device,device),[on,or,off],
	{getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,hasState(Device,State)))}.

hasDialogEntry('which devices are on').
dialogInterfaceQuery(Entry)  --> [which,devices,are],([] ; ['turned']),[on],
	{Entry = query(listTurnedOnDevices(TurnedOnDevices))}.

listTurnedOnDevices(TurnedOnDevices) :-
	view(1),
	getCurrentDateTime(DateTime),
	view(2),
	findall(Device,isa(Device,device),Devices),
	view(3),
	view([devices,Devices]),
	view(4),
	findall([Device,State],(member(Device,Devices),atTimeQuery(DateTime,hasState(Device,State))),DeviceStates),
	view(5),
	view([deviceStates,DeviceStates]),
	view(6),
	findall(Device,member([Device,on],DeviceStates),TurnedOnDevices),
	view(7),
	view([turned,TurnedOnDevices]).


%% fix this to reflect on which of the chores listed it was supposed to be done.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLANNER

hasDialogEntry('use voice commands to set planning goals and change the planning objects and initiate the IEM').

hasDialogEntry('retrieve bluetooth keyboard').




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IEM

hasDialogEntry('what,next').
dialogInterfaceQuery(Entry)  --> ([what,next] ; [what,is,the,next,step]),
	{Plan = planFn(1),
	 Entry = query(whatNext(Plan,Response))}.

whatNext(Plan,Response) :-
	planStepNumber(Plan,Step),
	getPlan('/var/lib/myfrdcsa/codebases/minor/agent-attempts/7/pddl/hygiene/',hygiene,[_,_,TransformedSteps]),
	member([Step,Tmp],TransformedSteps),
	nth1(4,Tmp,Tmp2),
	nth1(1,Tmp2,Response),
	view([response1,Response]).

hasDialogEntry('select plan <NUMBER>').
%% dialogInterfaceQuery(Entry)  --> ([current,step,completed] ; [completed]),
%% 	{Plan = planFn(1),
%% 	 Entry = query(currentPlanStepNumberCompleted(Plan,Response))}.

hasDialogEntry('replan').
%% dialogInterfaceQuery(Entry)  --> ([current,step,completed] ; [completed]),
%% 	{Plan = planFn(1),
%% 	 Entry = query(currentPlanStepNumberCompleted(Plan,Response))}.

hasDialogEntry('list objectives').

hasDialogEntry('add objective').
%% dialogInterfaceQuery(Entry)  --> ([current,step,completed] ; [completed]),
%% 	{Plan = planFn(1),
%% 	 Entry = query(currentPlanStepNumberCompleted(Plan,Response))}.

hasDialogEntry('remove objective').
%% dialogInterfaceQuery(Entry)  --> ([current,step,completed] ; [completed]),
%% 	{Plan = planFn(1),
%% 	 Entry = query(currentPlanStepNumberCompleted(Plan,Response))}.

hasDialogEntry('list preconditions').
hasDialogEntry('list effects').

hasDialogEntry('current step completed').
%% dialogInterfaceQuery(Entry)  --> ([current,step,completed] ; [completed]),
%% 	{Plan = planFn(1),
%% 	 Entry = query(currentPlanStepNumberCompleted(Plan,Response))}.

%% currentPlanStepNumberCompleted(Plan,Response) :-
%% 	planStepNumber(Plan,Step),
%% 	getPlan('/var/lib/myfrdcsa/codebases/minor/agent-attempts/7/pddl/hygiene/',hygiene,[_,_,TransformedSteps]),
%% 	member([Step,Tmp],TransformedSteps),
%% 	nth1(4,Tmp,Tmp2),
%% 	nth1(1,Tmp2,Response),
%% 	view([response1,Response]).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UTILITY MAXIMIZATION SYSTEM

%% hasDialogEntry('should I buy <PRODUCT>').
%% dialogInterfaceQuery(Entry)  --> [should],(([i] ; ['I']) ; [we]),([buy] ; [purchase]),grabber(Product,product),
%% 	{(currentAgent(Agent),
%% 	 getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,should(buy(Agent,Product)))))}.

hasDialogEntry('a <PRO_OR_CON> of buying <PRODUCT> is <TOKENS>').
dialogInterfaceQuery(Entry)  --> [a],grabber(ProOrCon,proOrCon),[of,buygin],grabber(Product,product),[is],oneOrMore(token,Tokens),
	{(currentAgent(Agent),
	  getCurrentDateTime(DateTime),
	  (   ProOrCon = pro -> (Entry = assert(atTime(DateTime,hasBenefit(buy(Agent,Product),statementFn(Tokens))))) ;
	      (	  ProOrCon = con -> (Entry = assert(atTime(DateTime,hasDetriment(buy(Agent,Product),statementFn(Tokens))))) ;
		  fail )))}.


%% HAVE THE ABILITY TO TELL IT ARBITRARY THINGS LIKE RULES, FOR
%% INSTANCE, LIKE IF REDACTED DOESN'T DO X SHE'LL HAVE PROBLEM Y NEXT
%% DAY


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% BILL PAYMENT SYSTEM

%% hasDialogEntry('there is a bill for comed for $50 this month').
%% dialogInterfaceQuery(Entry)  --> [should],(([i] ; ['I']) ; [we]),([buy] ; [purchase]),grabber(Product,product),
%% 	{(currentAgent(Agent),
%% 	 getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,should(buy(Agent,Product)))))}.

%% hasDialogEntry('We just paid the electric bill').
%% dialogInterfaceQuery(Entry)  --> [should],(([i] ; ['I']) ; [we]),([buy] ; [purchase]),grabber(Product,product),
%% 	{(currentAgent(Agent),
%% 	 getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,should(buy(Agent,Product)))))}.
%% %% atTime([2018-1-1,12:0:0],paid(Payer,Payee,Purpose))

%% hasDialogEntry('the electric bill is due on the 24th').
%% dialogInterfaceQuery(Entry)  --> [should],(([i] ; ['I']) ; [we]),([buy] ; [purchase]),grabber(Product,product),
%% 	{(currentAgent(Agent),
%% 	 getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,should(buy(Agent,Product)))))}.

%% hasDialogEntry('was the <X> month water bill paid'?.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HUMOR


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UTIL

currently(Expression) :-
	getCurrentDateTime(DateTime),atTimeQuery(DateTime,Expression).





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INCOMING

hasDialogEntry('when was the last time (the room was vacuumed|<AGENT> took her meds').

hasDialogEntry('add function to paperless office to "gather all my (<TYPE>?)"').

hasDialogEntry('<AGENT> took her meds (just)? now').

hasDialogEntry('record ( prayers|the room)').
hasDialogEntry('the location X needs to be cleaned'). %% I.e. fridge




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% THEN EVENTUALLY LEVENSHTEIN HERE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% THEN EVENTUALLY DO RTE HERE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INCOMING

hasDialogEntry('what voice? commands are there for GOURMET').

hasDialogEntry('record living room').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROLOG-AGENT

hasDialogEntry('start recording in <ROOM>').

hasDialogEntry('stop recording in <ROOM>').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONSULTANT SUPPORT

%% (entry (switch to project P))
%% (entry (switch to client C))
%% (entry (start clock))
%% (entry (stop clock))

%% etc etc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% SVRS

hasDialogEntry('what is the? <CLIMATE_PROPERTY> (in the <INDOOR_LOCATION>|outside|in <GEOGRAPHICAL_LOCAITON>)').
dialogInterfaceQuery(Entry) --> [what,is],(dt ; []),grabber(ClimateProperty,climateProperty),(([in,the],grabber(IndoorLocation,indoorLocation)) ; [outside] ; ([in],grabber(GeographicLocation,geographicLocation))),
	{getCurrentDateTime(DateTime),
	 (   nonvar(IndoorLocation) ->
	     (	 Entry = query(hasClimatePropertyAt(IndoorLocation,ClimateProperty,Value)) );
	     (	 nonvar(GeographicLocation) ->
		 (   Entry = query(hasClimatePropertyAt(GeographicLocation,ClimateProperty,Value))) ;
		 true))}.

%% (entry (what is the forecast))

%% etc etc


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% MORE INCOMING

%% (have the ability to modify the entry post hoc, so that if I get
%% confused I can end the Alexa utterance with, '... (cancel|abort)
%% that?', and it will not act on it, and other such posthoc or
%% otherwise grammatical modifiers)

%% Add something where we can record and ask the name or purpose of a
%% timer or alarm, since Alexa's timer doesn't seem to natively do
%% this.  Eventually have it proffer the info with push notifications
%% when appropriate.

%% Track something else, not only where the person is, but some other
%% thing about the house like the windows, but what I forget.


%% (entry (I have X amount in my wallet)), other means of specifying
%% how much cash you have in different places.

desired(hasDialogEntry('can I have another <DRINK>?')).
desired(hasDialogEntry('I am having another <DRINK>.')).
desired(hasDialogEntry('(can|do) we recycle <ITEM> here?')).





dialogInterfaceQuery(Entry) --> [play],([playlist] ; ['Playlist']),grabber(Playlist,playlist),
	{Entry = query(playPlaylist(Agent,Playlist))}.

dialogInterfaceQuery(Entry) --> [play],([song];[songs]),grabber(Song,song),
	{Entry = query(playSong(Agent,Song))}.

dialogInterfaceQuery(Entry) --> [stop,music],
	{Entry = query(stopMusic(Agent))}.

%% %% push notification testing
dialogInterfaceQuery(Entry) --> ([close];[push];[quiz];[press];[fish]),([notification];[notifications]),oneOrMore(token,Tokens),
	{Entry = query(alexaPushNotificationHandler(Tokens))}.

%% dialogInterfaceQuery(Entry) --> ['333'],oneOrMore(token,Tokens),
%% 	{Entry = query(alexaPushNotificationHandler(Tokens))}.

dialogInterfaceQuery(Entry) --> [testing],(['123']; [one,two,three]),
	{Entry = query(alexaPushNotificationHandler([]))}.

dialogInterfaceQuery(Entry) --> [testing,testing,testing],
	{Entry = query(alexaPushNotificationHandler([]))}.


dialogInterfaceQuery(Entry) --> [set],(dt ; []),[volume],([on];[]),grabber(Computer,computer),([to];[]),number(Number),
	{%% getFirst(TmpUserName,hasUserNameOnSystem(Computer,_,TmpUserName),UserName),
	 %% view([userName,UserName]),
	 Entry = query(setLevel(hasPercentage(volumeLevel(loginFn(andrewdo,Computer),'analog-stereo'),Number)))}.

%% dialogInterfaceQuery(Entry) --> ([set] ; [create] ; [make]),([alarm] ; [timer]),([for] ; []),onOrMore(token,Tokens),
%% 	{getCurrentDateTime(Now),
%% 	 Entry = query(set(timerFn(Tokens,Now)))}.

%% dialogInterfaceQuery(Entry) --> ([cancel] ; [stop] ; [delete] ; [remove] ; [abort]),([alarm] ; [timer]),([for] ; []),onOrMore(token,Tokens),
%% 	{getCurrentDateTime(Now),
%% 	 Entry = query(cancel(timerFn(Tokens,_)))}.

%% dialogInterfaceQuery(Entry) --> [play,audio],grabber(AudioFileName,audioFileName),
%% 	{Entry = query(playAudioFile(AudioFileName))}.


%% ((alexa set timer (for?) 1 hour (20 minutes) (1 minute))
%%  (all that language)
%%  (in downstairs computer room, on all alexas in house, etc)
%%  (implement named timers, use mechanism for Notifications and
%%   Recurrences to do this, have predicate like,
%%   namedTimer(Location,DateTime,Message), etc.)
%%  (implement tomorrow)

%%  (finish /var/lib/myfrdcsa/codebases/internal/clear/Org::FRDCSA::Clear::Data.pl)
%% )


%% try to figure out which alice we are nearby, and hence which one
%% should be responded to, for instance, if we say set volume, etc.


%% dialogInterfaceQuery(Entry) --> [next,page],
%% 	{Entry = query(queryAgent('Agent1','Yaswi1','CLEAR','p',[],Result))}.

%% dialogInterfaceQuery(Entry) --> [previous,page],
%% 	{Entry = query(queryAgent('Agent1','Yaswi1','CLEAR','p',[],Result))}.

%% dialogInterfaceQuery(Entry) --> [pause],([reading];[clear]),
%% 	{Entry = query(queryAgent('Agent1','Yaswi1','CLEAR','p',[],Result))}.

dialogInterfaceQuery(Entry) --> [pause,reading],
	{Entry = query(pauseReading)}.

dialogInterfaceQuery(Entry) --> grabber(Agent,agent),[has],([a] ; []),((([level];[degree];[amount];[quantity];[]),grabber(ScalarVariable,scalarVariable)) ; (grabber(ScalarVariable,scalarVariable),([level];[degree];[amount];[quantity];[]))),([of] ; []),number(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasDegree(Agent,ScalarVariable,N)))}.

dialogInterfaceQuery(Entry) --> grabber(Agent,agent),([has];[his]),([a] ; []),((([level];[degree];[amount];[quantity];[]),grabber(ScalarVariable,scalarVariable)) ; (grabber(ScalarVariable,scalarVariable),([level];[degree];[amount];[quantity];[]))),([of] ; []),number(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasDegree(Agent,ScalarVariable,N)))}.


%% last command

%% make last command actually in context Context (i.e. fictional real)

%% undo last command

%% we should have logic that attempts to undo it, and then plans for
%% how to undo side effects that can't just be retracted and
%% recomputed


hasDialogEntry('<AGENT> took their (morning|afternoon|evening) medications').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([took];[take];[touches];[had]),([a];[the];[his];[her];[their];[there];[]),([morning]),([medication];[medications];[meditation];[meditations];[pill];[pills];[meds];[med]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(Agent,morningMedication)))}.

hasDialogEntry('<AGENT> took their (morning|afternoon|evening) medications').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([took];[take];[touches];[had]),([a];[the];[his];[her];[their];[there];[]),([evening];[night]),([medication];[medications];[meditation];[meditations];[pill];[pills];[meds];[med]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(Agent,eveningMedication)))}.

hasDialogEntry('<AGENT> declares? a mental health day').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([declare];[declares];[is,having];[had]),adt,[mental,health,day],
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(Agent,mentalHealthDay)))}.

hasDialogEntry('Today is a mental health day').
dialogInterfaceQuery(Entry)  --> [today,is,a,mental,health,day],
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(andrewDougherty,mentalHealthDay)))}.

hasDialogEntry('<AGENT> declares? an off day').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([declare];[declares];[is,having];[had]),adt,[off,day],
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(Agent,offDay)))}.

hasDialogEntry('Today is an off day').
dialogInterfaceQuery(Entry)  --> [today,is,an,off,day],
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(andrewDougherty,offDay)))}.

hasDialogEntry('change user to <AGENT>').
dialogInterfaceQuery(Entry)  --> ([change];[set]),([];[current]),[user],([];[to]),grabber(Agent,agent),
	{Entry = query(setByRetractingAllAndAsserting(currentAgent(Agent)))}.

hasDialogEntry('I took 1 advil').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([took];[had]),number(N),grabber(Medicine,medicine),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,took(Agent,qty(Medicine,N))))}.

hasDialogEntry('<AGENT> had <TOKENS> for (breakfast|lunch|dinner|a snack)').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([head];[had];[have];['I',have];[ahead]),oneOrMore(token,MealTokens),[for],grabber(MealTime,mealTime),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,consumed(Agent,for(MealTime,mealFn(MealTokens)))))}.


hasDialogEntry('<AGENT> had <MEAL> for (breakfast|lunch|dinner|a snack)').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([head];[had];[have];['I',have]),grabber(Meal,meal),[for],grabber(MealTime,mealTime),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,consumed(Agent,for(MealTime,Meal))))}.


hasDialogEntry('<MEAL> for <AGENT> was a <NUMBER>').
dialogInterfaceQuery(Entry)  --> grabber(MealTime,mealTime),[for],grabber(Agent,agent),[was],(dt;[a];[on]),number(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasDegree(mealFn(MealTime,deliciousness,Agent),N)))}.


hasDialogEntry('dinner for <AGENT> was a <NUMBER>').
dialogInterfaceQuery(Entry)  --> grabber(MealTime,mealTime),[for],grabber(Agent,agent),[was],(dt;[a];[on]),number(N),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,hasDegree(mealFn(MealTime,deliciousness,Agent),N)))}.

hasDialogEntry('wake <AGENT>').
dialogInterfaceQuery(Entry)  --> [wake],grabber(Agent,agent),
	{Entry = query(awaken(Agent,Result))}.


hasDialogEntry('<AGENT> just woke up').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([just];[]),([woke,up];[got,up];[got,out,of,bed]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,wokeUp(Agent)))}.

hasDialogEntry('<AGENT> is awake').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([is,awake];[has,arisen];[has,woken,up];[awoke];[has,awoken]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,isAwake(Agent)))}.

hasDialogEntry('<AGENT> just got out of bed').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([just];[]),([got,out,of,bed];[arose];[got,up]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,gotOutOfBed(Agent)))}.

hasDialogEntry('<AGENT> just went to bed').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([just];[]),([went,to,bed];[was,tucked,in];[lied,down];[got,into,bed]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,gotIntoBed(Agent)))}.

hasDialogEntry('<AGENT> just fell asleep').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([just];[]),([went,to,sleep];[fell,asleep]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,fellAsleep(Agent)))}.

hasDialogEntry('<AGENT> is asleep').
dialogInterfaceQuery(Entry)  --> grabber(Agent,agent),([is,asleep]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,isAsleep(Agent)))}.


hasDialogEntry('tell me the location of <AGENT>').

hasDialogEntry('start flp').
%% dialogInterfaceQuery(Entry)  --> [start,flp],
%% 	{Entry = query(wake(Agent))}.

hasDialogEntry('reload flp source files').
dialogInterfaceQuery(Entry)  --> [reload,flp,source,files],
	{Entry = query(shell_command_async('flp-client -r1'))}.

hasDialogEntry('reload flp').
dialogInterfaceQuery(Entry)  --> [reload,flp],
	{Entry = query(shell_command_async('flp-client -r2'))}.

hasDialogEntry('restart flp emacs session').
dialogInterfaceQuery(Entry)  --> [restart,flp,emacs,session],
	{Entry = query(shell_command_async('flp-client -r3'))}.


%% add interfaces for recording how soon something in the fridge will
%% go bad


hasDialogEntry('what is the <CONTACT_INFO> for <AGENT>').
dialogInterfaceQuery(Entry)  --> [what,is,the],grabber(ContactInfoType,contactInfoType),[for],([a];[]),grabber(Agent,agent),
	{Entry = query(hasContactInfo(Agent,ContactInfoType,ContactInfo))}.

hasContactInfo(Agent,ContactInfoType,ContactInfo) :-
	(   (	ContactInfoType = phoneNumber) ->
	    (	hasPhoneNumber(Agent,phoneNumberFn(ContactInfo)) ) ;
	    true ).


%% processes that need to automatically set timers

%% cooking food like pizza
%% charging batteries


%% say <AGENT> has a headache, <AGENT> has no headache anymore.  <AGENT> is not hungry.

hasDialogEntry('what is the climate in the computer room').
dialogInterfaceQuery(Entry)  --> [what,is,the],([temperature];[climate]),([in] ; [at] ; [of]),dt,grabber(Location,location),
	{Entry = query(hasClimatePropertyAt(Location,temperature,Temperature))}.

hasDialogEntry('what is the climate outside').
dialogInterfaceQuery(Entry)  --> [what,is,the],([temperature] ; [climate]),([] ; [outside] ; [like]),
	{Entry = query(hasClimatePropertyAt(flintMichigan,temperature,Temperature))}.

hasDialogEntry('record (sound|audio) in <ROOM>').
dialogInterfaceQuery(Entry)  --> ([start,recording];[record]),([audio] ; [sound] ; []),([in];[at]),grabber(Room,room),
	{Entry = query(startRecordingAudio(Room))}.

hasDialogEntry('stop recording (sound|audio) in <ROOM>').
dialogInterfaceQuery(Entry)  --> [stop,recording],([audio] ; [sound]),[in],grabber(Room,room),
	{Entry = query(stopRecordingAudio(Room))}.

hasDialogEntry('<DEVICE> set to <NUMBER> degrees').
dialogInterfaceQuery(Entry)  --> dt,grabber(Device,device),([is];[]),[set,to],number(N),([degrees];[]),
	{getCurrentDateTime(DateTime),
	 getGloss(Device,DeviceGloss),
	 atom_number(AtomN,N),
	 atomic_list_concat([the,DeviceGloss,has,been,turned,on,and,has,been,set,to,AtomN,degrees,fahrenheit],
	 		    ' ',
	 		    Message),
	 hasLocation(Device,Location),
	 hasResidents(Location,Residents),
	 member(Resident,Residents),
	 tell(Resident,[Message]),
	 Entry = assert(atTime(DateTime,deviceOnAndSetTo(Device,N)))}.

%% NOTES
%% (make a note that tomorrow is ambiguous after midnight)

%% hasDialogEntry('lock (screen(s)) (for|on|of) <COMPUTER>').
%% dialogInterfaceQuery(Entry)  --> [lock],grabber(Room,room),
%% 	{Entry = query(lockScreensOnComputer(Room))}.

hasDialogEntry('lock screen').
dialogInterfaceQuery(Entry)  --> [lock],([screen];[screens];[computer];[computers];[monitor];[monitors]),
	{Entry = query(lockScreensOnComputer(aiFrdcsaOrg))}.


%% hasDialogEntry('lock (screen(s)) (for|on|of) <COMPUTER>').
%% dialogInterfaceQuery(Entry)  --> [lock],grabber(Computer,computer),
%% 	{Entry = query(lockScreensOnComputer(Computer))}.

lockScreensOnComputer(System) :-
	%% System = aiFrdcsaOrg,
	%% currentAgent(Agent),
	Agent = andrewDougherty,
	hasLogin(Agent,loginFn(UserName,System)),
	executeCommandOnSystem(loginFn(UserName,System),
			       [
				'/var/lib/myfrdcsa/codebases/internal/kmax/scripts/screensaver.sh'
			       ]).

hasDialogEntry('(launch|start) cameras').
dialogInterfaceQuery(Entry)  --> ([launch];[lens];[lanz];[start];[turn,on]),([camera];[cameras]),
	{Entry = query(launchCamerasOnComputer(redactedComputer))}.


%% hasDialogEntry('lock (screen(s)) (for|on|of) <COMPUTER>').
%% dialogInterfaceQuery(Entry)  --> [lock],grabber(Computer,computer),
%% 	{Entry = query(lockScreensOnComputer(Computer))}.

launchCamerasOnComputer(System) :-
	%% System = aiFrdcsaOrg,
	%% currentAgent(Agent),
	Agent = andrewDougherty,
	hasLogin(Agent,loginFn(UserName,System)),
	executeCommandOnSystem(loginFn(UserName,System),
			       [
				'/var/lib/myfrdcsa/codebases/minor/video-surveillance/scripts/launch-cameras.sh'
			       ]).


hasDialogEntry('play clip <CLIP>').
dialogInterfaceQuery(Entry)  --> [play],([clip] ; [clips] ; [click] ; [clicks] ; [club] ; [clubs]),grabber(Clip,mediaLibraryVideoOrSoundClip),
	{Entry = query(playClip(Clip))}.

playClip(Clip) :-
	hasClipBaseName(Clip,ClipBaseName),
	UserName = andrewdo,
	System = aiFrdcsaOrg,
	ensureBluetoothSpeakerConnected(loginFn(UserName,System)),
	maximizeVolumeOnDevice(loginFn(UserName,System),'analog-stereo'),
	atomic_list_concat(['mplayer -ao pulse::bluez_sink.30_21_54_57_D8_9B -af volume=15:0 -fs -zoom -geometry 1920x1080+1920+0 \\"<clips-directory>/',ClipBaseName,'\\"'],Command),
	executeCommandOnSystem(loginFn(andrewdo,aiFrdcsaOrg),
			       [
				Command
			       ]).

%% Add a Cancel, abort, etc.

hasDialogEntry('echo <TOKENS>').
dialogInterfaceQuery(Entry)  --> [echo],oneOrMore(token,Tokens),
	{Entry = query(echo(Tokens))}.

echo(HI) :-
	true.

hasDialogEntries(['please repeat','please repeat last entry']).

hasDialogEntry('add goal <GOAL>').
dialogInterfaceQuery(Entry)  --> ([add];[new]),[goal],oneOrMore(tokens,Tokens),
	{getCurrentDateTime(DateTime),
	 translateTokensIntoGoal(Tokens,Goal),
	 Entry = query(addGoal(DateTime,Goal))}.

hasDialogEntry('add goal <GOAL>').
dialogInterfaceQuery(Entry)  --> ([remove];[delete];[cancel];[stop];[retract]),[goal],oneOrMore(token,Tokens),
	{getCurrentDateTime(DateTime),
	 translateTokensIntoGoal(Tokens,Goal),
	 Entry = query(removeGoal(DateTime,Goal))}.

hasDialogEntry('<AGENT> had a BM').
dialogInterfaceQuery(Entry)  --> grabber(agent,Agent),([had];[has]), ([a];[]),(token,Tokens),
	{getCurrentDateTime(DateTime),
	 translateTokensIntoGoal(Tokens,Goal),
	 Entry = query(removeGoal(DateTime,Goal))}.

%% hasDialogEntry('stop Alexa').
%% dialogInterfaceQuery(Entry)  --> [stop,alexa],
%% 	{Entry = query(tell(andrewDougherty,['Alexa, stop']))}.


%% hasDialogEntry('acknowledge pin <NUMBER> <NUMBER> <NUMBER>').
%% dialogInterfaceQuery(Entry)  --> ([acknowledge];[acknowledging];[acknowledged];[at,knowledge];[at,knowledging];[at,knowledged]),[pin],grabber(number,Number1),grabber(number,Number2),grabber(number,Number3),
%% 	{Entry = query(acknowledgePin([Number1,Number2,Number3]))}.

hasDialogEntry('acknowledge pin <NUMBER> <NUMBER> <NUMBER>').
dialogInterfaceQuery(Entry)  --> ([acknowledge];[acknowledging];[acknowledged];[at,knowledge];[at,knowledging];[at,knowledged]),[pin],oneOrMore(token,Pin),
	{Entry = query(acknowledgePin([Pin]))}.

hasDialogEntry('red alert').
dialogInterfaceQuery(Entry)  --> [red,alert],
	{Entry = query(redAlert)}.

redAlert :-
	true.


hasDialogEntry('object X (went|is|must be) (missing|lost|misplaced)').
dialogInterfaceQuery(Entry)  --> grabber(Object,object),([is];[went];[must,be]),([missing];[lost];[misplaced]),
	{getCurrentDateTime(DateTime),
	 Entry = assert(atTime(DateTime,isLost(Object)))}.

hasDialogEntry('start E V A').
dialogInterfaceQuery(Entry)  --> [start,e,v,a],
	{Entry = query(startEVA)}.

hasDialogEntry('start EVA').
dialogInterfaceQuery(Entry)  --> [start,'EVA'],
	{Entry = query(startEVA)}.

startEVA :-
	getCurrentDateTime(DateTime),
	%% assert(atTime(DateTime,startedEva)).

	%% %% do all the consequent planning and such
	true.

hasDialogEntry('activate contingency <CONTINGENCY>').
dialogInterfaceQuery(Entry)  --> ([mark,contingency,active];[activate,contingency]),oneOrMore(tokens,Tokens),
	{getCurrentDateTime(DateTime),
	 translateTokensIntoGoal(Tokens,Contingency),
	 activateContingency(Contingency),
	 %% Entry = assert(atTime(DateTime,isLost(Object)))
	 true
	 }.

%%  (when is agent coming over next)
%%  (what time is it)
%%  (what date is it)
%%  (what day is it)
%%  (when is my next doctors appointment)
%%  (what is the purpose of my next doctors appointment)

desires(hasDialogEntry('the trash is full (in the computer room)')).

%% Use contralog to do RTE to match with dialogInterfaceQuerys

hasDialogEntry('say happy birthday to <AGENT>').
dialogInterfaceQuery(Entry)  --> ([say];[sing]),([happy,birthday,to]),grabber(Agent,agent),
	{Entry = query(sayHappyBirthdayToAgent(Agent))}.

sayHappyBirthdayToAgent(Agent) :-
	true.

desires(hasDialogEntry('<AGENT> called <AGENT>')).
desires(hasDialogEntry('when did <AGENT> last (wake up|call <AGENT>)')).

hasDialogEntry('<AGENT1> called <AGENT2>').
dialogInterfaceQuery(Entry)  --> grabber(Agent1,agent),['called'],grabber(Agent2,agent),
	{getCurrentDateTime(Now),
	 Entry = assert(atTime(Now,called(Agent1,Agent2)))}.

dialogInterfaceQuery(Entry)  --> ['when','did'],grabber(Agent,agent),['last','wake','up'],
	{getCurrentDateTime(Now),
	 Entry = query(atTimeQuery(Now,wokeUp(Agent)))}.
%% dialogInterfaceQuery(Entry)  --> ['when','did'],grabber(Agent1,agent),['last','call'],grabber(Agent2,agent),
%% 	{getCurrentDateTime(Now),
%% 	 atTimeLastEntry(Now,called(Agent1,Agent2),Result),
%% 	 Entry = query((Now,called(Agent1,Agent2)))}.

hasDialogEntry('the? <OBJECT> is <OBJECTSTATE>').
hasDialogExample('the cpap is dirty').
dialogInterfaceQuery(Entry)  --> dt,grabber(Object,object),['is'],grabber(ObjectState,objectState),
	{getCurrentDateTime(Now),
	 Fact =.. [ObjectState,Object],
	 Entry = assert(atTime(Now,Fact))}.

hasDialogEntry('the? <OBJECT> is not <OBJECTSTATE>').
hasDialogExample('the cpap is not dirty').
dialogInterfaceQuery(Entry)  --> dt,grabber(Object,object),['is','not'],grabber(ObjectState,objectState),
	{getCurrentDateTime(Now),
	 TmpFact =.. [ObjectState,Object],
	 Fact =.. [neg,TmpFact],
	 Entry = assert(atTime(Now,Fact))}.


hasDialogEntry('request permission to <ACTION>').
hasDialogExample('request permission to leave the room').
dialogInterfaceQuery(Entry)  --> ['request'],(['permission'];['clearance']),(['to'];[]),grabber(COA,courseOfAction),
	{getCurrentDateTime(Now),
	 currentAgent(Agent),
	 Entry = query(requestPermissionTo(Agent,Now,COA))}.

hasDialogExample('what is my score').
hasDialogExample('what is my score (for the day)?').

hasDialogEntry('tell <COUNSELOR> <THING>').
dialogInterfaceQuery(Entry)  --> ([tell];[talk,to]),grabber(Counselor,counselor),([about];[]),oneOrMore(token,Tokens),
	{getCurrentDateTime(Now),
	 currentAgent(Agent),
	 hasCounselor(Agent,Counselor),
	 Entry = assert(atTime(Now,tell(Agent,Counselor,Tokens)))}.

hasDialogEntry('begin isolation').
dialogInterfaceQuery(Entry)  --> ([begin,isolation];[begin,isolating];[begin,quarantine]),
	{getCurrentDateTime(Now),
	 currentAgent(Agent),
	 Entry = assert(atTime(Now,begin(quarantine(Agent))))}.

hasDialogEntry('are we quarantining').
dialogInterfaceQuery(Entry) --> ([are,we,quarantining];[are,we,still,quarantining];[are,we,in,quaratine];[are,we,still,in,quaratine];[are,we,isolating];[are,we,still,isolating]),
	{getCurrentDateTime(Now),
	 currentAgent(Agent),
	 Entry = query(areWeStillQuarantining(Now,Agent,_Response))}.

%% atTime(X,behaviorActionPlan([behavior(Y),mood(increases)])).
hasDialogEntry('mood <RATE_OF_CHANGE> behavior is <BEHAVIOR>,').
dialogInterfaceQuery(Entry) --> ([mood]),grabber(Trend,trend),([behavior,is]),oneOrMore(token,Behavior),
	{getCurrentDateTime(Now),
	 currentAgent(Agent),
	 Entry = assert(atTime(Now,behaviorActionPlan([behavior(Behavior),mood(Trend)])))}.
