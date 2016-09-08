control primitives
primitiveValueWithArgs
	| argumentArray blockContext blockArgumentCount arrayArgumentCount initialIP |
	argumentArray := self popStack.
	blockContext := self popStack.
	blockArgumentCount := self argumentCountOfBlock: blockContext.
	"If the argArray isnt actually an Array we ahve to unpop the above two"
	(self isArray: argumentArray) ifFalse: [self unPop:2. ^self primitiveFail].

	successFlag ifTrue: [arrayArgumentCount := self numSlotsOf: argumentArray.
			self success: (arrayArgumentCount = blockArgumentCount
						and: [(self fetchPointer: CallerIndex ofObject: blockContext) = nilObj])].
	successFlag
		ifTrue: [self
				transfer: arrayArgumentCount
				fromIndex: 0
				ofObject: argumentArray
				toIndex: TempFrameStart
				ofObject: blockContext.
			"Assume: The call to transfer:... makes blockContext a root if necessary, 
			allowing use to use unchecked stored in the following code. "
			initialIP := self fetchPointer: InitialIPIndex ofObject: blockContext.
			self
				storePointerUnchecked: InstructionPointerIndex
				ofObject: blockContext
				withValue: initialIP.
			self storeStackPointerValue: arrayArgumentCount inContext: blockContext.
			self
				storePointerUnchecked: CallerIndex
				ofObject: blockContext
				withValue: activeContext.
			self newActiveContext: blockContext]
		ifFalse: [self unPop: 2]