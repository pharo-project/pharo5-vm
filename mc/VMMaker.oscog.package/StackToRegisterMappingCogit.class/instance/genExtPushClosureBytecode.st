bytecode generators
genExtPushClosureBytecode
	"Block compilation.  At this point in the method create the block.  Note its start
	 and defer generating code for it until after the method and any other preceeding
	 blocks.  The block's actual code will be compiled later."
	"253		11111101 eei i i kkk	jjjjjjjj		Push Closure Num Copied iii (+ Ext A // 16 * 8) Num Args kkk (+ Ext A \\ 16 * 8) BlockSize jjjjjjjj (+ Ext B * 256). ee = num extensions"
	| numArgs numCopied |
	self assert: needsFrame.
	self addBlockStartAt: bytecodePC + 3 "0 relative"
		numArgs: (numArgs := (byte1 bitAnd: 16r7) + (extA \\ 16 * 8))
		numCopied: (numCopied := ((byte1 >> 3) bitAnd: 7) + (extA // 16 * 8))
		span: byte2 + (extB << 8).
	extA := extB := 0.

	objectRepresentation createsClosuresInline ifTrue:
		[self assert: objectRepresentation getActiveContextAllocatesInMachineCode.
		 optStatus isReceiverResultRegLive: false.
		 self ssAllocateCallReg: ReceiverResultReg
			and: SendNumArgsReg
			and: ClassReg.
		 objectRepresentation
			genNoPopCreateClosureAt: bytecodePC + 4 "1 relative"
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
		genCreateClosureAt: bytecodePC + 4 "1 relative"
		numArgs: numArgs
		numCopied: numCopied
		contextNumArgs: methodOrBlockNumArgs
		large: (coInterpreter methodNeedsLargeContext: methodObj)
		inBlock: inBlock.
	numCopied > 0 ifTrue:
		[self ssPop: numCopied].
	^self ssPushRegister: ReceiverResultReg