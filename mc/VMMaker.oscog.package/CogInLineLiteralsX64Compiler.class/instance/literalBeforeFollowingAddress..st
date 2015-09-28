inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the literal embedded in the instruction immediately preceeding followingAddress.
	 This is used in the MoveCwR and CmpCwR cases; these are distinguished by a nop following
	 the literal load in MoveCwR, and a (self mod: ModReg RM: rX RO: rY) following the CmpCwR."
	| base |
	base := followingAddress - ((objectMemory byteAt: followingAddress - 1) = 16r90
									ifTrue: [9]
									ifFalse: [11]).
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