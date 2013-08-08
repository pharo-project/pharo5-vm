initialization
initializeInterpreter: bytesToShift 
	super initializeInterpreter: bytesToShift.
	foreignCallbackProcessSlot := (objectMemory lengthOf: objectMemory specialObjectsOop) > ForeignCallbackProcess
										ifTrue: [ForeignCallbackProcess]
										ifFalse: [NilObject]