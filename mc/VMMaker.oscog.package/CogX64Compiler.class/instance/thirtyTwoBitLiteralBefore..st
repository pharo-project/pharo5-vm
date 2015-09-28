inline cacheing
thirtyTwoBitLiteralBefore: followingAddress
	<inline: true>
	^self cCode: [objectMemory unalignedLong32At: followingAddress - 5]
		inSmalltalk: [   ((objectMemory byteAt: followingAddress - 1) << 24)
					+ ((objectMemory byteAt: followingAddress - 2) << 16)
					+ ((objectMemory byteAt: followingAddress - 3) << 8)
					+  (objectMemory byteAt: followingAddress - 4)]