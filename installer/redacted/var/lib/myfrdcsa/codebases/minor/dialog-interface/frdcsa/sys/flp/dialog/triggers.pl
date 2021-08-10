eventHasTrigger(assert(atTime(DateTime,gotIntoBed(Agent))),scheduleNotifications(DateTime,[30,60,90,120,150],checkTemperatureOfAgent(Agent))).

%% another approach is just to check for recent such assertions, and
%% do them, periodically
