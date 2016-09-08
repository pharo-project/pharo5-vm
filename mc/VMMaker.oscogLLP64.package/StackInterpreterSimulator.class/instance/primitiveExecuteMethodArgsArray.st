control primitives
primitiveExecuteMethodArgsArray
	self halt: thisContext selector.
	"(objectMemory isOopCompiledMethod: self stackTop) ifFalse:
		[self halt]."
	^super primitiveExecuteMethodArgsArray