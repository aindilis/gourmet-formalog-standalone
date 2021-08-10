%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CONFIGURATION

curGaeilgeArSeo(setByRetractingAllAndAsserting(currentAgent(Agent)),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([changed,current,agent,to,AgentGloss],' ',Gaeilge),!.

curGaeilgeArSeo(setByRetractingAllAndAsserting(currentSpeaker(Agent)),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([changed,current,speaker,to,AgentGloss],' ',Gaeilge),!.

curGaeilgeArSeo(setByRetractingAllAndAsserting(currentWSMContext(Context)),Gaeilge) :-
	getGloss(Context,ContextGloss),
	atomic_list_concat([changed,current,context,to,ContextGloss],' ',Gaeilge),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DATES

curGaeilgeArSeo(whenIsAgent1NextAppointmentWithAgent2(Agent1,_,-1),Gaeilge) :-
	getGloss(Agent1,Agent1Gloss),
	atomic_list_concat([Agent1Gloss,does,not,have,any,more,appointments],' ',Gaeilge),!.
	
curGaeilgeArSeo(whenIsAgent1NextAppointmentWithAgent2(Agent1,Agent2,AppointmentID),Gaeilge) :-
	meetingInfo(AppointmentID,DateTime,Desc,MeetingParticipants,MeetingAgenda,MeetingLocations,MeetingPhoneNumbers),
	view([meetingInfo,[AppointmentID,DateTime,Desc,MeetingParticipants,MeetingAgenda,MeetingLocations,MeetingPhoneNumbers]]),
	(   nonvar(Agent2) ->
	    getGloss(Agent2,Agent2Gloss) ;
	    true),
	getGloss(Agent1,Agent1Gloss),generateGlossFor(DateTime,DateTimeGloss),
	hasGender(Agent1,Gender),
	hasGenderPronoun(Gender,Pronoun),
	view([dateTimeGloss,DateTimeGloss]),
	(   nonvar(Agent2) ->
	    atomic_list_concat([Agent1Gloss,has,Pronoun,next,appointment,with,Agent2Gloss,on,DateTimeGloss],' ',Gaeilge) ;
	    atomic_list_concat([Agent1Gloss,has,Pronoun,next,appointment,on,DateTimeGloss],' ',Gaeilge)),
	!.

%% (how many days until <DATE>)
curGaeilgeArSeo(daysUntilDate([CurrentDate],Date,Days),Gaeilge) :-
	atomic_list_concat([Date,is,in,Days,days],' ',Gaeilge),!.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROFILES

%% Entry = assert(atTime(DateTime,likes(CurrentAgent,Thing)))}.
curGaeilgeArSeo(likes(Agent,Thing),Gaeilge) :-
	getGloss(Agent,AgentGloss),getGloss(Thing,ThingGloss),
	atomic_list_concat([AgentGloss,likes,ThingGloss],' ',Gaeilge),!.

%% Entry = assert(atTime(DateTime,neg(likes(CurrentAgent,Thing))))}.
curGaeilgeArSeo(neg(likes(Agent,Thing)),Gaeilge) :-
	getGloss(Agent,AgentGloss),getGloss(Thing,ThingGloss),
	atomic_list_concat([AgentGloss,does,not,like,ThingGloss],' ',Gaeilge),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AUDIENCE

%% Entry = execute(call(CurrentAgent,Agent,about(Tokens)))}.

%% ask <AGENT> <QUESTION>
%% tell <AGENT> <INFORMATION>

%% (ask <AGENT> <QUESTION>)
curGaeilgeArSeo(ask(Agent,question(TokenizedQuestion)),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	append([going,to,ask,AgentGloss],TokenizedQuestion,Response),
	atomic_list_concat(Response,' ',Gaeilge),!.

curGaeilgeArSeo(tell(Agent,TokenizedStatement),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat(TokenizedStatement,' ',Statement),
	atomic_list_concat(['I',told,AgentGloss,Statement],' ',Gaeilge).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FINANCIAL DECISION SUPPORT SYSTEM

%% Entry = assert(atTime(DateTime,loaned(Agent1,Agent2,dollars(N))))}.
curGaeilgeArSeo(loaned(Agent1,Agent2,dollars(N)),Gaeilge) :-
	getGloss(Agent1,Agent1Gloss),getGloss(Agent2,Agent2Gloss),
	atom_concat('$',N,D),
	atomic_list_concat([Agent1Gloss,loaned,Agent2Gloss,D],' ',Gaeilge),!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% AKAHIGE

%% Entry = assert(atTime(DateTime,hasSymptom(Agent,eyesAreStinging)))}.
%% Entry = assert(atTime(DateTime,hasSymptom(Agent,aspiration)))}.
%% Entry = assert(atTime(DateTime,hasCondition(Agent,Condition)))}.
%% Entry = assert(atTime(DateTime,painLevel(Agent,N)))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% GOURMET

%% Entry = assert(atTime(DateTime,ate(Agent,Food)))}.
curGaeilgeArSeo(ate(Agent,Food),Gaeilge) :-
	getGloss(Agent,AgentGloss),getGloss(Food,FoodGloss),
	atomic_list_concat([AgentGloss,ate,FoodGloss],' ',Gaeilge),!.

%% Entry = query(predict(next(DateTime,atTime(DateTime,isHungry(Agent)))))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DO-TODO-LIST

%% Entry = assert(atTime(DateTime,alexaToDoListTask(Tokens)))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INVENTORY MANAGER

curGaeilgeArSeo(location(Object,Location),Gaeilge) :-
	getGloss(Object,ObjectGloss),getGloss(Location,LocationGloss),
	atomic_list_concat([the,ObjectGloss,is,located,in,the,LocationGloss],' ',Gaeilge),!.

%% Entry = assert(atTime(DateTime,outOfStock(townhome,Object)))}.
%% Entry = query(atTime(DateTime,hasInventory(townhome,Object,Units)))}.
%% Entry = assert(atTime(DateTime,hasInventory(townhome,Object,N)))}.
%% {integer(Time),Entry = assert(atTime(Time,location(Object,Location)))}.
%% {integer(Time),currentAgent(Agent),Entry = assert(atTime(Time,saw(Agent,location(Object,Location))))}.
%% {getCurrentDateTime(DateTime),Entry = query(atTimeQuery(DateTime,location(Object,X))),view([entry,Entry])}.
%% {integer(Time),Entry = query(atTimeQuery(Time,location(Symbol,X)))}.
%% {getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,location(Object,Location)))}.
%% {getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,location(Object,Location)))}.
%% {getCurrentDateTime(DateTime),Entry = assert(atTime(DateTime,byDefault(location(Object,Location))))}.
%% {Entry = query(atTimeQuery(DateTime,byDefault(location(Object,Location))))}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% DISCIPLE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% CHORES

curGaeilgeArSeo(completed(Agent,choreFn(Chore)),Gaeilge) :-
	getGloss(Agent,AgentGloss),getGloss(Chore,ChoreGloss),
	atomic_list_concat([AgentGloss,finished,ChoreGloss],' ',Gaeilge),!.

%% Doors

%% Windows

curGaeilgeArSeo(hasState(Openable,OpenableState),Gaeilge) :-
	isa(Openable,openable),
	view(hasState(Openable,OpenableState)),
	getGloss(Openable,OpenableGloss),getGloss(OpenableState,OpenableStateGloss),
	atomic_list_concat([the,OpenableGloss,is,OpenableStateGloss],' ',Gaeilge),!.

curGaeilgeArSeo(listOpenWindows(Windows),Gaeilge) :-
	( findall(WindowGloss,(member(Window,Windows),getGloss(Window,WindowGloss)),WindowGlosses)),
	view([windowGlosses,WindowGlosses]),
	renderList(WindowGlosses,List),
	append([the,following,windows,are,open,':'],List,All),
	view([all,All]),
	atomic_list_concat(All,' ',Gaeilge),!.


%% Devices

curGaeilgeArSeo(hasState(Device,DeviceState),Gaeilge) :-
	isa(Device,device),
	view(hasState(Device,DeviceState)),
	getGloss(Device,DeviceGloss),getGloss(DeviceState,DeviceStateGloss),
	atomic_list_concat([the,DeviceGloss,is,DeviceStateGloss],' ',Gaeilge),!.

curGaeilgeArSeo(listTurnedOnDevices(Devices),Gaeilge) :-
	( findall(DeviceGloss,(member(Device,Devices),getGloss(Device,DeviceGloss)),DeviceGlosses)),
	view([deviceGlosses,DeviceGlosses]),
	renderList(DeviceGlosses,List),
	append([the,following,devices,are,on,':'],List,All),
	view([all,All]),
	atomic_list_concat(All,' ',Gaeilge),!.


%% helper functions

renderList([First],[the,First]).
renderList([First,Last],[the,First,and,the,Last]).
renderList([First|Rest],List) :-
	length([First|Rest],X),X>2,
	reverse([the,First,','|Rest],[NextFirst|NextRest]),
	reverse([NextFirst,the,and|NextRest],List).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLANNER

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% IEM

curGaeilgeArSeo(whatNext(Plan,Response),Gaeilge) :-
	Gaeilge = Response,!.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UTILITY MAXIMIZATION SYSETM

%% curGaeilgeArSeo(should(buy(Agent,Product)),Gaeilge) :-
%% 	getGloss(Agent,AgentGloss),
%% 	getGloss(Product,ProductGloss),	
%% 	append([buying,ProductGloss],All),
%% 	atomic_list_concat(All,' ',Gaeilge),!.

curGaeilgeArSeo(hasDetriment(buy(Agent,Product),statementFn(Tokens)),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	getGloss(Product,ProductGloss),	
	append([buying,ProductGloss,is,detrimental,because],Tokens,All),
	atomic_list_concat(All,' ',Gaeilge),!.

curGaeilgeArSeo(hasBenefit(buy(Agent,Product),statementFn(Tokens)),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	getGloss(Product,ProductGloss),	
	append([buying,ProductGloss,is,detrimental,because],Tokens,All),
	atomic_list_concat(All,' ',Gaeilge),!.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% HUMOR



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% UTIL






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% INCOMING

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


curGaeilgeArSeo(playPlaylistFor(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat(['Playing',playlist,for,AgentGloss],' ',Gaeilge).

curGaeilgeArSeo(alexaPushNotificationHandler(Tokens),Gaeilge) :-
	read_data_from_file('/var/lib/myfrdcsa/codebases/minor/dialog-interface/data-git/push-notification-text.txt',TmpGaeilge),
	chomp(TmpGaeilge,Gaeilge).

curGaeilgeArSeo(setLevel(hasPercentage(volumeLevel(loginFn(UserName,Computer),'analog-stereo'),Number)),Gaeilge) :-
	getGloss(Computer,ComputerGloss),
	atomic_list_concat([volume,for,UserName,on,ComputerGloss,set,to,Number,percent],' ',Gaeilge).

curGaeilgeArSeo(hasInventory(Location,Product,Quantity),Gaeilge) :-
	getGloss(Location,LocationGloss),
	getGloss(Product,ProductGloss),
	atomic_list_concat([the,LocationGloss,has,Quantity,of,ProductGloss],' ',Gaeilge).

curGaeilgeArSeo(hasContactInfo(Agent,ContactInfoType,ContactInfo),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	getGloss(ContactInfoType,ContactInfoTypeGlossa),
	atomic_list_concat([Agent,has,ContactInfoType,ContactInfo],' ',Gaeilge).

curGaeilgeArSeo(hasContactInfo(Agent,ContactInfoType,ContactInfo),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	getGloss(ContactInfoType,ContactInfoTypeGlossa),
	atomic_list_concat([Agent,has,ContactInfoType,ContactInfo],' ',Gaeilge).

curGaeilgeArSeo(summon(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([AgentGloss,has,been,summoned],' ',Gaeilge).

curGaeilgeArSeo(checkOn(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([checking,on,AgentGloss],' ',Gaeilge).

curGaeilgeArSeo(hasClimatePropertyAt(Location,temperature,Temperature),Gaeilge) :-
	getGloss(Location,LocationGloss),
	atomic_list_concat([the,temperature,in,LocationGloss,is,Temperature,degrees,fahrenheit],' ',Gaeilge).

curGaeilgeArSeo(consumed(Agent,for(MealTime,Meal)),Gaeilge) :-
	Meal \= mealFn(_),
	getGloss(Agent,AgentGloss),
	getGloss(MealTime,MealTimeGloss),
	getGloss(Meal,MealGloss),
	atomic_list_concat([AgentGloss,had,MealGloss,for,MealTimeGloss],' ',Gaeilge).

curGaeilgeArSeo(consumed(Agent,for(MealTime,TmpMeal)),Gaeilge) :-
	TmpMeal = mealFn(Meal),
	getGloss(Agent,AgentGloss),
	getGloss(MealTime,MealTimeGloss),
	atomic_list_concat(Meal,' ',MealConcatenation),
	atomic_list_concat([AgentGloss,had,MealConcatenation,for,MealTimeGloss],' ',Gaeilge).

curGaeilgeArSeo(hasAwoken(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([AgentGloss,has,woken,up],' ',Gaeilge).

curGaeilgeArSeo(hasGoneToSleep(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([AgentGloss,has,gone,to,sleep],' ',Gaeilge).

curGaeilgeArSeo(deviceOnAndSetTo(Device,N),Gaeilge) :-
	getGloss(Device,DeviceGloss),
	atomic_list_concat([the,DeviceGloss,has,been,turned,on,and,has,been,set,to,N,degrees,fahrenheit],
			   ' ',
			   Gaeilge).

curGaeilgeArSeo(echo(Tokens),Gaeilge) :-
	append([echo],Tokens,List),
	atomic_list_concat(List,' ',Gaeilge).

curGaeilgeArSeo(lockScreensOnComputer(Computer),Gaeilge) :-
	getGloss(Computer,ComputerGloss),
	atomic_list_concat([locking,ComputerGloss],' ',Gaeilge).

curGaeilgeArSeo(launchCamerasOnComputer(Computer),Gaeilge) :-
	getGloss(Computer,ComputerGloss),
	atomic_list_concat([launching,cameras,on,ComputerGloss],' ',Gaeilge).

curGaeilgeArSeo(acknowledgePin(Pin),Gaeilge) :-
	%% append([[acknowledging,pin],Pin],List),
	atomic_list_concat([acknowledging,pin],' ',Gaeilge).

curGaeilgeArSeo(redAlert,Gaeilge) :-
	atomic_list_concat([red,alert],' ',Gaeilge).

%% curGaeilgeArSeo(masterOfTheUniverse,Gaeilge) :-
%% 	atomic_list_concat([justin,coslor,is,the,master,of,the,universe],' ',Gaeilge).

curGaeilgeArSeo(isLost(Object),Gaeilge) :-
	getGloss(Object,ObjectGloss),
	atomic_list_concat([ObjectGloss,is,missing],' ',Gaeilge).

curGaeilgeArSeo(startEVA,Gaeilge) :-
	atomic_list_concat([e,v,a,started],' ',Gaeilge).

curGaeilgeArSeo(activateContingency(Contingency),Gaeilge) :-
	getGloss(Contingency,ContingencyGloss),
	atomic_list_concat([contingency,activated,ContingencyGloss],' ',Gaeilge).

curGaeilgeArSeo(sayHappyBirthdayToAgent(Agent),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	atomic_list_concat([happy,birthday,to,AgentGloss,happy,birthday,to,AgentGloss,happy,birthday,to,AgentGloss,happy,birthday,to,AgentGloss],' ',Gaeilge).

curGaeilgeArSeo(requestPermissionTo(Agent,Now,COA),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	getGloss(COA,COAGloss),
	atomic_list_concat([permission,granted,to,AgentGloss,to,COAGloss],' ',Gaeilge).

%% curGaeilgeArSeo(requestPermissionTo(Agent,Now,COA),Gaeilge) :-
%% 	getGloss(Agent,AgentGloss),
%% 	getGloss(COA,COAGloss),
%% 	atomic_list_concat([permission,denied,to,AgentGloss,to,COAGloss],' ',Gaeilge).

curGaeilgeArSeo(areWeStillQuarantining(Now,Agent,Response),Gaeilge) :-
	getGloss(Agent,AgentGloss),
	(   Response = yes -> 
	    atomic_list_concat([Agent,is,still,quarantining],' ',Gaeilge) ;
	    atomic_list_concat([Agent,is,not,quarantining],' ',Gaeilge)).