debugging traps
externalCannotReturn: resultOop from: aContext
	self halt.
	^super externalCannotReturn: resultOop from: aContext