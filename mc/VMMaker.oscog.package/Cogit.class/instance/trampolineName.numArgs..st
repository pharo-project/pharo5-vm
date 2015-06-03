initialization
trampolineName: routinePrefix numArgs: numArgs
	^self trampolineName: routinePrefix numArgs: numArgs limit: NumSendTrampolines - 2