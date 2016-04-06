control primitives
primitiveClosureValue
	| blockClosure numArgs closureMethod outerContext |
	blockClosure := self stackValue: argumentCount.
	numArgs := self argumentCountOfClosure: blockClosure.
	argumentCount = numArgs ifFalse:
		[^self primitiveFail].

	(self is: blockClosure instanceOf: (objectMemory splObj: ClassBlockClosure) compactClassIndex: ClassBlockClosureCompactIndex)
		ifTrue: 
			[ "Somewhat paranoiac checks we need while debugging that we may be able to discard
			 in a robust system."
			outerContext := objectMemory fetchPointer: ClosureOuterContextIndex ofObject: blockClosure.
			(objectMemory isContext: outerContext) ifFalse:
				[^self primitiveFail].
			closureMethod := objectMemory fetchPointer: MethodIndex ofObject: outerContext.
			"Check if the closure's method is actually a CompiledMethod."
			(objectMemory isOopCompiledMethod: closureMethod) ifFalse:
				[^self primitiveFail].

			"Note we use activateNewMethod, not executeNewMethod, to avoid
			 quickCheckForInterrupts.  Don't check until we have a full activation."
			self activateNewClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: true ]
		ifFalse: 
			[ closureMethod := objectMemory fetchPointer: FullClosureCompiledBlockIndex ofObject: blockClosure.
			(objectMemory isOopCompiledMethod: closureMethod)
				ifFalse: [ ^ self primitiveFail ].
			"Note we use activateNewMethod, not executeNewMethod, to avoid
			 quickCheckForInterrupts.  Don't check until we have a full activation."
			self activateNewFullClosureMethod: blockClosure numArgs: numArgs mayContextSwitch: true ]