control primitives
primitiveFullClosureValueWithArgs
	<option: #SistaV1BytecodeSet>
	| argumentArray arraySize blockClosure numArgs closureMethod index |
	argumentArray := self stackTop.
	(objectMemory isArray: argumentArray) ifFalse:
		[^self primitiveFail].

	"Check for enough space in thisContext to push all args"
	arraySize := objectMemory numSlotsOf: argumentArray.
	(self roomToPushNArgs: arraySize) ifFalse:
		[^self primitiveFail].

	blockClosure := self stackValue: argumentCount.
	numArgs := self argumentCountOfClosure: blockClosure.
	arraySize = numArgs ifFalse:
		[^self primitiveFail].


	closureMethod := objectMemory fetchPointer: FullClosureCompiledBlockIndex ofObject: blockClosure.
	(objectMemory isOopCompiledMethod: closureMethod) ifFalse:
		[^self primitiveFail].

	self popStack.

	"Copy the arguments to the stack, and activate"
	index := 1.
	[index <= numArgs] whileTrue:
		[self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray).
		index := index + 1].

	self activateNewFullClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: true