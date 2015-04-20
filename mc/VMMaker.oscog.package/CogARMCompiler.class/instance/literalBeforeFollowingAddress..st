inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the long constant loaded by a MOV/ORR/ORR/ORR
	 or MOV/ORR/ORR/ORR/PUSH  sequence, just before this address:"
	^(self instructionIsOR: (objectMemory longAt: followingAddress - 4))
		ifTrue:
			[   ((objectMemory byteAt: followingAddress - 16) << 24)
			+  ((objectMemory byteAt: followingAddress - 12) << 16)
			+  ((objectMemory byteAt: followingAddress - 8) << 8)
			+   (objectMemory byteAt: followingAddress - 4)]
		ifFalse:
			[   ((objectMemory byteAt: followingAddress - 20) << 24)
			+  ((objectMemory byteAt: followingAddress - 16) << 16)
			+  ((objectMemory byteAt: followingAddress - 12) << 8)
			+   (objectMemory byteAt: followingAddress - 8)]