allIsa(Item,Results) :-
	setof(Class,Item^isa(Item,Class),Results).

are([real,fictional],wsmContext).
hasEnglishGlossesData(real,['Real','real']).
hasEnglishGlossesData(fictional,['Fictional','fictional']).

hasGenderPronoun(male,'his').
hasGenderPronoun(female,'her').

hasGender(andrewDougherty,male).

hasEnglishGlossesData(andrewDougherty,['Andrew','Andy','andy','andrew','Andrew Dougherty','andrew dougherty','Andy Dougherty','andy dougherty','and I','And I','and drew','And Drew','And drew']).

are([andrewDougherty],agent).

%% genlsDirectlyList([person],intelligentAgent).
%% genlsDirectlyList([car],automobile).

are([happy,sad,hungry,pain,haveToGoTheBathroom,tiredness],scalarVariable).
hasEnglishGlossesData(happiness,['happiness']).
hasEnglishGlossesData(sadness,['sadness']).
hasEnglishGlossesData(hunger,['hunger']).
hasEnglishGlossesData(pain,['pain']).
hasEnglishGlossesData(haveToGoTheBathroom,['bathroom','use bathroom','has to go to the bathroom']).
hasEnglishGlossesData(tiredness,['tiredness']).

are([happy,sad,depressed,tired,hungry,thirsty,tooHot,tooCold,warm,cool,psychotics,sugarAttack,toothAche],condition).
hasEnglishGlossesData(happy,['happy']).
hasEnglishGlossesData(sad,['sad']).
hasEnglishGlossesData(depressed,['depressed']).
hasEnglishGlossesData(tired,['tired']).
hasEnglishGlossesData(hungry,['hungry']).
hasEnglishGlossesData(thirsty,['thirsty']).
hasEnglishGlossesData(tooHot,['too hot']).
hasEnglishGlossesData(tooCold,['too cold']).
hasEnglishGlossesData(warm,['warm']).
hasEnglishGlossesData(cool,['cool']).
hasEnglishGlossesData(toothAche,['toothache','tooth ache']).
hasEnglishGlossesData(bloated,['bloated','abdominal bloating','abdominal pressure']).

atTime([2017-1-1,12:0:0.0], location(bluetoothKeyboard,kitchen)).
atTime([2017-2-1,12:0:0.0], location(bluetoothKeyboard,livingRoom)).

isa(vanillaPudding,food).
isa(cottageCheese,food).
isa(scrambledEggs,food).
isa(meat,foodType).

hasEnglishGlossesData(vanillaPudding,['vanilla pudding']).
hasEnglishGlossesData(cottageCheese,['cottage cheese']).
hasEnglishGlossesData(scrambledEggs,['scrambled eggs']).
hasEnglishGlossesData(meat,['meat','meet']).

%% genls(person,intelligentAgent).

%% are([grapes,honeyNutCheerios,yogurtWithMapleSyrup,quinoaWithChickenBrothAndCheese,eggs],food).
isa(crackers,food).
isa(grapes,food).
isa(honeyNutCheerios,food).
isa(yogurtWithMapleSyrup,food).
isa(quinoaWithChickenBrothAndCheese,food).
isa(eggs,food).

hasEnglishGlossesData(crackers,['crackers']).


%% hasEnglishGlossesData(grapes,['grapes']).
hasEnglishGlossesData(honeyNutCheerios,['Honey Nut Cheerios','Cheerios','honey nut cheerios','cheerios']).
hasEnglishGlossesData(yogurtWithMapleSyrup,['Yogurt']).
hasEnglishGlossesData(quinoaWithChickenBrothAndCheese,['Quinoa']).
hasEnglishGlossesData(eggs,['Eggs']).

are([kitchen,livingRoom,downstairsComputerRoom],room).
are([home,kitchen,livingRoom,downstairsComputerRoom,downstairsFoyer,garage],location).
hasEnglishGlossesData(home,['home']).
hasEnglishGlossesData(kitchen,['kitchen']).
hasEnglishGlossesData(downstairsComputerRoom,['computer room','downstairs computer room']).
hasEnglishGlossesData(livingRoom,['living room']).

are([computerRoomDoor,doorToGarage,garageDoor],door).

door(computerRoomDoor,downstairsComputerRoom,downstairsFoyer).
door(doorToGarage,downstairsFoyer,garage).
door(garageDoor,garage,outside).

isa(tissues,object).
isa(bluetoothKeyboard,object).
hasEnglishGlossesData(tissues,['tissues']).
hasEnglishGlossesData(bluetoothKeyboard,['Bluetooth keyboard','bluetooth keyboard','keyboard']).

are([pepsi,vernors,water],drink).
hasEnglishGlossesData(pepsi,['pepsi','Pepsi']).
hasEnglishGlossesData(vernors,['vernors','Vernors']).
hasEnglishGlossesData(water,['water']).

%% isa(Y,medication) :-
%% 	hasMedication(X,Y).

are([cpap,downstairsComputerRoomFloor],object).
hasEnglishGlossesData(cpap,['cpap','CPAP']).
are([clean,dirty],objectState).
hasEnglishGlossesData(clean,['clean']).
hasEnglishGlossesData(dirty,['dirty']).

opposites(clean,dirty).

%% genlsDirectlyList([openableState,deviceState],state).

genlsDirectlyList([window,door],openable).

isa(open,openableState).
isa(closed,openableState).

isa(on,deviceState).
isa(off,deviceState).

isa(pro,proOrCon).
isa(con,proOrCon).

isa(oven,device).
isa(stove,device).
%% isa(centralAirConditioner,device).
%% isa(objectLocatedInFn(vent,downstairsComputerRoom),device).
isa(objectLocatedInFnVentDownstairsComputerRoom,openable).

hasEnglishGlossesData(objectLocatedInFnVentDownstairsComputerRoom,['downstairs air vent']).

isa(kitchenWindow,window).
isa(slidingDoor,window).
isa(livingRoomWindows,window).
isa(landingWindow,window).
isa(computerRoomWindow,window).

hasEnglishGlossesData(garageDoor,['garage door']).

isa(chestPain,symptom).
isa(headache,symptom).
isa(coughed,symptom).
isa(choked,symptom).
isa(aspirated,syptom).
isa(psychotics,symptom).
isa(sugarAttack,symptom).
isa(bloated,symptom).
%% get something stuck in one's throat

hasEnglishGlossesData(chestPain,['Chest pain','Chestpain','chest pain','chestpain']).
hasEnglishGlossesData(headache,['head ache','headache']).
hasEnglishGlossesData(coughed,['cough','coughed']).
hasEnglishGlossesData(choked,['choke','choked']).
hasEnglishGlossesData(aspirated,['aspirate','aspirated']).
hasEnglishGlossesData(psychotics,['psychotic','psychotics','psychoses','psychosis']).
hasEnglishGlossesData(sugarAttack,['sugar attack','blood sugar attack','low blood sugar','low sugar']).

hasEnglishGlossesData(stove,['stove','Stove','stove burner','Stove burner','stove burners','Stove burners']).
hasEnglishGlossesData(oven,['oven','Oven']).
%% hasEnglishGlossesData(centralAirConditioner,['air conditioner','air conditioning','Air conditioner','Air conditioning','central air conditioner','Central air conditioner','central air conditioning','Central air conditioning','air','Air']).

hasEnglishGlossesData(kitchenWindow,['kitchen window']).
hasEnglishGlossesData(slidingDoor,['sliding door']).
hasEnglishGlossesData(livingRoomWindows,['living room windows']).
hasEnglishGlossesData(landingWindow,['landing window']).
hasEnglishGlossesData(computerRoomWindow,['computer room window']).

functionalInArgs(location/2,2).
functionalInArgs(hasState/2,2).
functionalInArgs(hasInventory/3,3).

%% hasEnglishGlossesData(Downcased,Y) :-
%% 	hasEnglishGlossesData(X,Y),
%% 	downcase_atom(X,Downcased),
%% 	X \= Downcased.

are([preparedAMeal,vacuumed,didTheDishes,brushedTeeth,paidSomeBills,paidTheRent,spongeBathed,showered],chore).
hasEnglishGlossesData(preparedAMeal,['prepared a meal','cooked','prepared Emile']).
hasEnglishGlossesData(vacuumed,['vacuum','vacuuming','vacuumed']).
hasEnglishGlossesData(didTheDishes,['did the dishes']).
hasEnglishGlossesData(brushedTeeth,['brushed teeth','brush teeth','brush','brushed']).
hasEnglishGlossesData(paidSomeBills,['paid some bills']).
hasEnglishGlossesData(paidTheRent,['paid the rent','paid the rent bill']).
hasEnglishGlossesData(spongeBathed,['sponge bathed','sponge bath']).
hasEnglishGlossesData(showered,['showered','shower']).

are([redactedComputer],computer).
hasEnglishGlossesData(redactedComputer,['computer','main computer','a I','A I','ai','ai dot frdcsa dot org','andys computer']).

are([nightMusic],playlist).
hasEnglishGlossesData(nightMusic,['night music','Night Music','Night music']).

are([happiness,sadness,hunger,pain,haveToGoTheBathroom,tiredness],scalarVariable).
hasEnglishGlossesData(happiness,['happiness']).
hasEnglishGlossesData(sadness,['sadness']).
hasEnglishGlossesData(hunger,['hunger']).
hasEnglishGlossesData(pain,['pain']).
hasEnglishGlossesData(haveToGoTheBathroom,['bathroom','use bathroom','has to go to the bathroom']).
hasEnglishGlossesData(tiredness,['tiredness']).

are([livingRoomBathroom,downstairsComputerRoom],room).
genlsDirectlyList([room],location).
hasEnglishGlossesData(livingRoomBathroom,['bathroom','living room bathroom']).
%% hasEnglishGlossesData(downstairsComputerRoom,['computer room','downstairs computer room']).

are([tissues,toiletPaper,paperTowels],product).
%% genls([tissues,toiletPaper,paperTowels],paperCleaningProduct).

hasEnglishGlossesData(tissues,['tissues']).
hasEnglishGlossesData(toiletPaper,['toilet paper']).
hasEnglishGlossesData(paperTowels,['paper towels']).

%% canBeMisrecognizedAs(tissues,['to shoes']).

are([flp,household],planningCapsule).
hasEnglishGlossesData(flp,['flp']).
hasEnglishGlossesData(household,['household']).

are([upstairsUtilityCloset],location).

hasEnglishGlossesData(upstairsUtilityCloset,['upstairs utility closet','utility closet']).

%% come up with substituability logic here.

%% substitutesInContext([creamCheese,butter],cooking).

are([ibuprofen,tylenol,advil,alleve],medicine).
hasEnglishGlossesData(ibuprofen,['Ibuprofen','ibuprofen']).
hasEnglishGlossesData(tylenol,['tylenol','Tylenol']).
hasEnglishGlossesData(advil,['Advil','advil']).
hasEnglishGlossesData(alleve,['Alleve','alleve']).

are([breakfast,lunch,dinner,supper,teaTime,coffeeBreak],mealTime).
hasEnglishGlossesData(breakfast,['breakfast']).
hasEnglishGlossesData(lunch,['lunch']).
hasEnglishGlossesData(dinner,['dinner']).
hasEnglishGlossesData(supper,['supper']).
hasEnglishGlossesData(teaTime,['tea time']).
hasEnglishGlossesData(coffeeBreak,['coffee break']).

are([lasagna],meal).
hasEnglishGlossesData(lasagna,['lasagne']).

are([temperature,humidity,pressure],indoorClimateCondition).
are([temperature,humidity,pressure,windSpeed],outdoorClimateCondition).

hasEnglishGlossesData(temperature,['temperature']).
hasEnglishGlossesData(humidity,['humidity']).
hasEnglishGlossesData(pressure,['pressure']).
hasEnglishGlossesData(windSpeed,['wind speed']).



%% FIXME: have that they are locations inferred
are([home,kitchen,livingRoom,downstairsComputerRoom,downstairsFoyer,garage],indoorLocation).
are([auroraIllinois,outside],outdoorLocation).

are([auroraIllinois,flintMichigan],city).

genlsDirectlyList([indoorLocation,outdoorLocation],location).

hasEnglishGlossesData(outside,['outside','outdoors']).
hasEnglishGlossesData(auroraIllinois,['Aurora','aurora','Aurora, Illinois','aurora, illinois','Aurora Illinois','aurora illinois','aurora Illinois']).

are([phoneNumber,emailAddress,instantMessageAddress],contactInfoType).
hasEnglishGlossesData(phoneNumber,['phone number']).

%% hasLocation(centralAirConditioner,townhome).
hasResidents(townhome,[andrewDougherty]).

hasEnglishGlossesData(recurrence(event),['recurring event']).
hasEnglishGlossesData(planStep(start),['plan step start']).
hasEnglishGlossesData(planStep(end),['plan step end']).

isa(townhome,location).
hasEnglishGlossesData(townhome,['Townhome']).

are([startEVA],courseOfAction).
hasEnglishGlossesData(startEVA,['leave the room','leave room','start eva','start EVA','start E V A']).

are([increases,decreases,remainsStable],trend).
hasEnglishGlossesData(increases,[increases]).
hasEnglishGlossesData(decreases,[decreases]).
hasEnglishGlossesData(remainsStable,['remains stable']).
