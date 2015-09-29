inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the literal embedded in the instruction immediately preceding followingAddress.
	 This is used in the MoveCwR, PushCwR and CmpCwR cases; these are distinguished by a
	 nop following the literal load in MoveCwR, a 16r50 + reg ending the PushCwR sequence, and
	 a (self mod: ModReg RM: rX RO: rY) ending the CmpCwR sequence, which is at least 16rC0."
	| lastByte base |
	lastByte := objectMemory byteAt: followingAddress - 1.
	base := followingAddress - (lastByte <= 16r90
									ifTrue:
										[lastByte = 16r90
											ifTrue: [9]		"MoveCwR"
											ifFalse: [10]]	"PushCwR"
									ifFalse: [11]).			"ArithCwR"
	^self cCode: [objectMemory unalignedLongAt: base]
		inSmalltalk:
			[   (objectMemory byteAt: base)
			+ ((objectMemory byteAt: base + 1) << 8)
			+ ((objectMemory byteAt: base + 2) << 16)
			+ ((objectMemory byteAt: base + 3) << 24)
			+ ((objectMemory byteAt: base + 4) << 32)
			+ ((objectMemory byteAt: base + 5) << 40)
			+ ((objectMemory byteAt: base + 6) << 48)
			+ ((objectMemory byteAt: base + 7) << 52)]