become
restoreHeaderOf: obj to: objHeader
	super restoreHeaderOf: obj to: objHeader.
	(self isContextHeader: objHeader) ifTrue:
		[(self asserta: ((coInterpreter isStillMarriedContext: obj) not)) ifFalse:
			[self error: 'attempt to become married context']]