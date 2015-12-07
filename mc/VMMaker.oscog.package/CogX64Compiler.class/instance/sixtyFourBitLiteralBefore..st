inline cacheing
sixtyFourBitLiteralBefore: followingAddress
	<inline: true>
	^self cCode: [objectMemory unalignedLongAt: followingAddress - 9]
		inSmalltalk: [   ((objectMemory byteAt: followingAddress - 1) << 56)
					+ ((objectMemory byteAt: followingAddress - 2) << 48)
					+ ((objectMemory byteAt: followingAddress - 3) << 40)
					+ ((objectMemory byteAt: followingAddress - 4) << 32)
					+ ((objectMemory byteAt: followingAddress - 5) << 24)
					+ ((objectMemory byteAt: followingAddress - 6) << 16)
					+ ((objectMemory byteAt: followingAddress - 7) << 8)
					+  (objectMemory byteAt: followingAddress - 8)]