control primitives
primitiveClosureCopyWithCopiedValues
	| newClosure numArgs |
	numArgs := self stackIntegerValue: 1.
	self successful ifFalse:
		[^self primitiveFail].

	newClosure := self
					closureIn: (self stackValue: 2)
					numArgs: numArgs
							"greater by 1 due to preIncrement of localIP"
					instructionPointer: instructionPointer + 2 - (method+objectMemory baseHeaderSize)
					copiedValues: self stackTop.
	self pop: 3 thenPush: newClosure