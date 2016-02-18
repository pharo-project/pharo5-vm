initialization
trampolineName: routinePrefix numArgs: numArgs
	<returnTypeC: #'char *'>
	<var: #routinePrefix type: #'char *'>
	^self trampolineName: routinePrefix numArgs: numArgs limit: NumSendTrampolines - 2