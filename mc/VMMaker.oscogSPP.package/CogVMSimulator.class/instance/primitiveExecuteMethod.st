debugging traps
primitiveExecuteMethod
	self halt: thisContext selector.
	^super primitiveExecuteMethod