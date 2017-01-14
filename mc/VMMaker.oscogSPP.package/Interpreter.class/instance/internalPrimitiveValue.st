control primitives
internalPrimitiveValue
	<sharedCodeNamed: 'commonPrimitiveValue' inCase: #bytecodePrimValue>
	| newContext blockArgumentCount initialIP |
	successFlag := true.
	newContext := self internalStackValue: argumentCount.
	self assertClassOf: newContext is: (self splObj: ClassBlockContext).
	blockArgumentCount := self argumentCountOfBlock: newContext.

	self success: (argumentCount = blockArgumentCount and: [(self fetchPointer: CallerIndex ofObject: newContext) = nilObj]).

	successFlag
		ifTrue: ["This code assumes argCount can only = 0 or 1"
			argumentCount = 1
				ifTrue: [self storePointer: TempFrameStart ofObject: newContext withValue: self internalStackTop].
			self internalPop: argumentCount + 1.
			"copy the initialIP value to the ip slot"
			initialIP := self fetchPointer: InitialIPIndex ofObject: newContext.
			self storePointerUnchecked: InstructionPointerIndex ofObject: newContext withValue: initialIP.
			self storeStackPointerValue: argumentCount inContext: newContext.
			self storePointerUnchecked: CallerIndex ofObject: newContext withValue: activeContext.
			self internalNewActiveContext: newContext]
		ifFalse: [messageSelector := self specialSelector: 25 + argumentCount.
			self normalSend]