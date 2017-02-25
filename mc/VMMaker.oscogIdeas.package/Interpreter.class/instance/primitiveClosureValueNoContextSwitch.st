control primitives
primitiveClosureValueNoContextSwitch
	"An exact clone of primitiveClosureValue except that this version will not
	 check for interrupts on stack overflow."
	| blockClosure blockArgumentCount closureMethod outerContext |
	blockClosure := self stackValue: argumentCount.
	blockArgumentCount := self argumentCountOfClosure: blockClosure.
	argumentCount = blockArgumentCount ifFalse:
		[^self primitiveFail].

	"Somewhat paranoiac checks we need while debugging that we may be able to discard
	 in a robust system."
	outerContext := self fetchPointer: ClosureOuterContextIndex ofObject: blockClosure.
	(self isContext: outerContext) ifFalse:
		[^self primitiveFail].
	closureMethod := self fetchPointer: MethodIndex ofObject: outerContext.
	"Check if the closure's method is actually a CompiledMethod."
	(self isOopCompiledMethod: closureMethod) ifFalse:
		[^self primitiveFail].

	self activateNewClosureMethod: blockClosure