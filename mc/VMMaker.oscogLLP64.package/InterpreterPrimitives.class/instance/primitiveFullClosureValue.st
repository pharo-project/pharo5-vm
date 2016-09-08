control primitives
primitiveFullClosureValue
	<option: #SistaV1BytecodeSet>
	| blockClosure numArgs closureMethod |
	blockClosure := self stackValue: argumentCount.
	numArgs := self argumentCountOfClosure: blockClosure.
	argumentCount = numArgs ifFalse:
		[^self primitiveFail].

	closureMethod := objectMemory fetchPointer: FullClosureCompiledBlockIndex ofObject: blockClosure.
	(objectMemory isOopCompiledMethod: closureMethod) ifFalse:
		[^self primitiveFail].

	self activateNewFullClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: true