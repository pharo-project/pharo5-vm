initialization
generateRunTimeTrampolines
	"Generate the run-time entries at the base of the native code zone and update the base."
	
	ceSendMustBeBooleanAddFalseLongTrampoline := self genMustBeBooleanLongTrampolineFor: objectMemory falseObject
														called: 'ceSendMustBeBooleanAddFalseTrampoline'.
	ceSendMustBeBooleanAddTrueLongTrampoline := self genMustBeBooleanLongTrampolineFor: objectMemory trueObject
														called: 'ceSendMustBeBooleanAddTrueTrampoline'.
	super generateRunTimeTrampolines