bytecode generators
genPushClosureCopyCopiedValuesBytecode
	"Block compilation.  At this point in the method create the block.  Note its start
	 and defer generating code for it until after the method and any other preceeding
	 blocks.  The block's actual code will be compiled later."
	"143   10001111 llllkkkk jjjjjjjj iiiiiiii	Push Closure Num Copied llll Num Args kkkk BlockSize jjjjjjjjiiiiiiii"
	| numArgs numCopied |
	self assert: needsFrame.
	self addBlockStartAt: bytecodePC + 4 "0 relative"
		numArgs: (numArgs := byte1 bitAnd: 16rF)
		numCopied: (numCopied := byte1 >> 4)
		span: (byte2 << 8) + byte3.

	objectRepresentation createsClosuresInline ifTrue:
		[self assert: objectRepresentation getActiveContextAllocatesInMachineCode.
		 optStatus isReceiverResultRegLive: false.
		 self ssAllocateCallReg: ReceiverResultReg
			and: SendNumArgsReg
			and: ClassReg.
		 objectRepresentation
			genNoPopCreateClosureAt: bytecodePC + 5 "1 relative"
			numArgs: numArgs
			numCopied: numCopied
			contextNumArgs: methodOrBlockNumArgs
			large: (coInterpreter methodNeedsLargeContext: methodObj)
			inBlock: inBlock.
		 1 to: numCopied do:
			[:i| | reg |
			 reg := self ssStorePop: true toPreferredReg: TempReg.
			 objectRepresentation
				genStoreSourceReg: reg
				slotIndex: ClosureFirstCopiedValueIndex + numCopied - i
				intoNewObjectInDestReg: ReceiverResultReg].
		 ^self ssPushRegister: ReceiverResultReg].

	numCopied > 0 ifTrue:
		[self ssFlushTo: simStackPtr].
	optStatus isReceiverResultRegLive: false.
	objectRepresentation getActiveContextAllocatesInMachineCode
		ifTrue: [self ssAllocateCallReg: ReceiverResultReg
					and: SendNumArgsReg
					and: ClassReg]
		ifFalse: [self ssAllocateCallReg: SendNumArgsReg
					and: ReceiverResultReg].
	objectRepresentation
		genCreateClosureAt: bytecodePC + 5 "1 relative"
		numArgs: numArgs
		numCopied: numCopied
		contextNumArgs: methodOrBlockNumArgs
		large: (coInterpreter methodNeedsLargeContext: methodObj)
		inBlock: inBlock.
	numCopied > 0 ifTrue:
		[self ssPop: numCopied].
	^self ssPushRegister: ReceiverResultReg