control primitives
primitiveClosureValueNoContextSwitch
	"An exact clone of primitiveClosureValue except that this version will not
	 check for interrupts on stack overflow.  It may invoke the garbage collector
	 but will not switch processes.  See checkForInterruptsMayContextSwitch:"
	<api>
	| blockClosure numArgs closureMethod outerContext |
	blockClosure := self stackValue: argumentCount.
	numArgs := self argumentCountOfClosure: blockClosure.
	argumentCount = numArgs ifFalse:
		[^self primitiveFail].

	"Somewhat paranoiac checks we need while debugging that we may be able to discard
	 in a robust system."
	outerContext := objectMemory fetchPointer: ClosureOuterContextIndex ofObject: blockClosure.
	(objectMemory isContext: outerContext) ifFalse:
		[^self primitiveFail].

	closureMethod := objectMemory fetchPointer: MethodIndex ofObject: outerContext.
	"Check if the closure's method is actually a CompiledMethod."
	(objectMemory isOopCompiledMethod: closureMethod) ifFalse:
		[^self primitiveFail].

	self activateNewClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: false