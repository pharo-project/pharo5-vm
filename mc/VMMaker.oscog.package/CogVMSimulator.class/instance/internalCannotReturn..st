debugging traps
internalCannotReturn: resultOop
	self halt.
	^super internalCannotReturn: resultOop