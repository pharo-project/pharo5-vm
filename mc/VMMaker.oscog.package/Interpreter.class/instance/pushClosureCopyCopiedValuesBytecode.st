stack bytecodes
pushClosureCopyCopiedValuesBytecode
	"The compiler has pushed the values to be copied, if any.  Find numArgs and numCopied in the byte following.
	 Create a Closure with space for the copiedValues and pop numCopied values off the stack into the closure.
	 Set numArgs as specified, and set startpc to the pc following the block size and jump over that code."
	| newClosure numArgsNumCopied numArgs numCopied blockSize |
	numArgsNumCopied := self fetchByte.
	numArgs := numArgsNumCopied bitAnd: 16rF.
	numCopied := numArgsNumCopied bitShift: -4.
	"Split blockSize := (self fetchByte * 256) + self fetchByte. into two because evaluation order in C is undefined."
	blockSize := self fetchByte << 8.
	blockSize := blockSize + self fetchByte.
	self externalizeIPandSP. "This is a pain."
	newClosure := self
					closureNumArgs: numArgs
					instructionPointer: ((self cCoerce: localIP to: 'sqInt') + 2 - (method+self baseHeaderSize))
					numCopiedValues: numCopied.
	self internalizeIPandSP.
	"Assume: have just allocated a new closure; it must be young. Thus, can use unchecked stores."
	self storePointerUnchecked: ClosureOuterContextIndex ofObject: newClosure withValue: activeContext.
	reclaimableContextCount := 0. "The closure refers to thisContext so it can't be reclaimed."
	numCopied > 0 ifTrue:
		[0 to: numCopied - 1 do:
			[:i|
			"Assume: have just allocated a new BlockClosure; it must be young.
			 Thus, can use unchecked stores."
			 self storePointerUnchecked: i + ClosureFirstCopiedValueIndex
				ofObject: newClosure
				withValue: (self internalStackValue: numCopied - i - 1)].
		 self internalPop: numCopied].
	localIP := localIP + blockSize.
	self fetchNextBytecode.
	self internalPush: newClosure