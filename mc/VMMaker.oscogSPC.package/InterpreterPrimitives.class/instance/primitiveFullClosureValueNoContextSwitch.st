control primitives
primitiveFullClosureValueNoContextSwitch
	"An exact clone of primitiveFullClosureValue except that this version will not
	 check for interrupts on stack overflow.  It may invoke the garbage collector
	 but will not switch processes.  See checkForInterruptsMayContextSwitch:"
	<api>
	<option: #SistaV1BytecodeSet>
	| blockClosure numArgs closureMethod |
	blockClosure := self stackValue: argumentCount.
	numArgs := self argumentCountOfClosure: blockClosure.
	argumentCount = numArgs ifFalse:
		[^self primitiveFail].

	closureMethod := objectMemory fetchPointer: FullClosureCompiledBlockIndex ofObject: blockClosure.
	(objectMemory isOopCompiledMethod: closureMethod) ifFalse:
		[^self primitiveFail].

	self activateNewFullClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: false