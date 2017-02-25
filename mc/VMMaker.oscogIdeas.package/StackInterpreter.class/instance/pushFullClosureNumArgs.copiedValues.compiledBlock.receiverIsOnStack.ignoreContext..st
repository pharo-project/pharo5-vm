stack bytecodes
pushFullClosureNumArgs: numArgs copiedValues: numCopiedArg compiledBlock: compiledBlock receiverIsOnStack: receiverIsOnStack ignoreContext: ignoreContext
	"The compiler has pushed the values to be copied, if any. The receiver has been pushed on stack before if specified. 
	 Create a Closure with space for the copiedValues and pop numCopied values off the stack into the closure.
	 Sets outerContext, compiledBlock, numArgs and receiver as specified.."
	<inline: true>
	| numCopied newClosure context startIndex |
	"No need to record the pushed copied values in the outerContext."
	context := ignoreContext
		ifTrue: [objectMemory nilObject ]
		ifFalse: [self ensureFrameIsMarried: localFP SP: localSP + (numCopiedArg * objectMemory bytesPerOop)].
	newClosure := self
					fullClosureIn: context 
					numArgs: numArgs 
					numCopiedValues: numCopiedArg 
					compiledBlock: compiledBlock.
	receiverIsOnStack
		ifFalse: 
			[ startIndex := FullClosureFirstCopiedValueIndex.
			   objectMemory storePointerUnchecked: FullClosureReceiverIndex
				ofObject: newClosure
				withValue: self receiver.
			numCopied := numCopiedArg ]
		ifTrue:
			[ startIndex := FullClosureReceiverIndex.
			numCopied := numCopiedArg + 1 ].
	numCopied > 0 ifTrue:
		[0 to: numCopied - 1 do:
			[ :i |
			"Assume: have just allocated a new BlockClosure; it must be young.
			 Thus, can use unchecked stores."
			 objectMemory storePointerUnchecked: i + startIndex
				ofObject: newClosure
				withValue: (self internalStackValue: numCopied - i - 1)].
		 self internalPop: numCopied].
	self fetchNextBytecode.
	self internalPush: newClosure