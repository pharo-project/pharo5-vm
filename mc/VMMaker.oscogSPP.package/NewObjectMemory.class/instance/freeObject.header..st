become
freeObject: obj header: objHeader
	(self isContextHeader: objHeader) ifTrue:
		[(self asserta: ((coInterpreter isStillMarriedContext: obj) not)) ifFalse:
			[self error: 'attempt to free married context']].
	super freeObject: obj header: objHeader