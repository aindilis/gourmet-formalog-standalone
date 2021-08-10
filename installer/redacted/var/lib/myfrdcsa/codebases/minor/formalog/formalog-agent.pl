formalog_toplevel(AgentName,FormalogName) :-
	repeat,
	formalog_listen(AgentName,FormalogName,Connection),
	terminate(Connection).

terminate(Connection) :-
	not(Connection = nil),
	fail.
terminate(Connection) :-
	Connection = nil,
	true.

formalog_process_message(Message) :-
	%% execute the command and send back the response
	print_result([message,Message]).

formalog_listen(AgentName,FormalogName,Connection) :-
	connectToUniLang(AgentName,FormalogName,Connection),
	formalog_listen_helper(AgentName,FormalogName,Connection).

formalog_listen_helper(AgentName,FormalogName,Connection) :-
	Connection = nil,
	write('Cannot connect to UniLang.'),nl,
	halt.
formalog_listen_helper(AgentName,FormalogName,Connection) :-
	not(Connection = nil),
	perl5_method(Connection,'ListenAndReceive',[AgentName,FormalogName],RetVal),
	RetVal = [[AgentName,FormalogName,_,[[Receiver,ToBeEvaled]]]],
	print_result([ret,Receiver,ToBeEvaled]),
	process_result(AgentName,FormalogName,Connection,Receiver,ToBeEvaled).

process_result(AgentName,FormalogName,Connection,Receiver,ToBeEvaled) :-
	not(ToBeEvaled = []),
	ToBeEvaled = [Arg1,Arg2],
	print_result([toBeEvaled,ToBeEvaled]),

	%% catch(findnsols(1,Arg1,Arg2,RetVal1),Error,RetVal1 = Error),
	%% catch(call(Arg2),Error,RetVal1 = Error),
	catch(findall(Arg1,Arg2,RetVal1),Error,RetVal1 = Error),

	%% findall(Arg1,Arg2,RetVal1),

	%% print_result([evalResult,RetVal1]),

	%% There are a couple of ways that it could be queried.  We
	%% could fquery/kquery in order to query the FreeKBS2 KB with
	%% the data, but that's not what I think we want, or rather we
	%% should leave it as an option.  We must also be able to
	%% execute a prolog command and obtain the bindings.  Should
	%% probably use findall.
	
	%% read_term_from_atom(ToBeEvaled),

	%% fquery
	perl5_method(Connection,'ProcessEvaluatedResult',[AgentName,FormalogName,Receiver,RetVal1],RetVal2),
	print_result([retval,RetVal2]),nl.

process_result(AgentName,FormalogName,Connection,Receiver,ToBeEvaled) :-
	ToBeEvaled = [],
	squelch(AgentName),
	squelch(FormalogName),
	squelch(Connection),
	squelch(Receiver).

process_result_general(AgentName,FormalogName,Connection,Receiver,Goal,ExtraArgs,RetVal1) :-
	not(Functor = []),
	print_result([[functor,Goal],[args,ExtraArgs]]),
	catch(call(Goal),Error,RetVal1 = Error),
	%% Add something here to unify RetVal1 with Goal if RetVal1 in unbound
	%% print_result([evalResult,RetVal1]),

	%% There are a couple of ways that it could be queried.  We
	%% could fquery/kquery in order to query the FreeKBS2 KB with
	%% the data, but that's not what I think we want, or rather we
	%% should leave it as an option.  We must also be able to
	%% execute a prolog command and obtain the bindings.  Should
	%% probably use findall.
	
	%% read_term_from_atom(ToBeEvaled),

	%% fquery
	perl5_method(Connection,'ProcessEvaluatedResult',[AgentName,FormalogName,Receiver,RetVal1],RetVal2),
	print_result([retval,RetVal2]),nl.
process_result_general(AgentName,FormalogName,Connection,Receiver,Goal,ExtraArgs,RetVal1) :-
	ToBeEvaled = [],
	squelch(AgentName),
	squelch(FormalogName),
	squelch(Connection),
	squelch(Receiver),
	squelch(Goal),
	squelch(ExtraArgs),
	squelch(RetVal1).

see_result(AgentName,FormalogName,Result,Queue) :-
	squelch(Result),
	Queue = nil,
	true.
see_result(AgentName,FormalogName,Result,Queue) :-
	squelch(Result),
	not(Queue = nil),
	print_result([AgentName,FormalogName,Queue]).

print_result(Result) :-
	not(Result = nil),
	write('print_result'),nl,
	write_term(Result,[quoted(true)]),nl.
print_result(Result) :-
	squelch(Result).

formalog_list_packages(Result) :-
	perl5_eval('use Task2',_),
	perl5_method('Task2','ListPackages', [], [Result]).
