bytecode generators
genPushNewArrayBytecode
	| size popValues |
	self assert: needsFrame.
	optStatus isReceiverResultRegLive: false.
	(popValues := byte1 > 127)
		ifTrue: [self ssFlushTo: simStackPtr]
		ifFalse: [self ssAllocateCallReg: SendNumArgsReg and: ReceiverResultReg].
	size := byte1 bitAnd: 127.
	popValues ifFalse:
		[(self tryCollapseTempVectorInitializationOfSize: size) ifTrue:
			[^0]].
	objectRepresentation genNewArrayOfSize: size initialized: popValues not.
	popValues ifTrue:
		[size - 1 to: 0 by: -1 do:
			[:i|
			self PopR: TempReg.
			objectRepresentation
				genStoreSourceReg: TempReg
				slotIndex: i
				intoNewObjectInDestReg: ReceiverResultReg].
		 self ssPop: size].
	^self ssPushRegister: ReceiverResultReg