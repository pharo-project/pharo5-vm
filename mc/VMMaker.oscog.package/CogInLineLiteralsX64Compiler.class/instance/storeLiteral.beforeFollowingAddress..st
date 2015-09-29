inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceding followingAddress.
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
	self cCode: [objectMemory unalignedLongAt: base put: literal]
		inSmalltalk:
			[objectMemory
				byteAt: base put: (literal bitAnd: 16rFF);
				byteAt: base + 1 put: ((literal >> 8) bitAnd: 16rFF);
				byteAt: base + 2 put: ((literal >> 16) bitAnd: 16rFF);
				byteAt: base + 3 put: ((literal >> 24) bitAnd: 16rFF);
				byteAt: base + 4 put: ((literal >> 32) bitAnd: 16rFF);
				byteAt: base + 5 put: ((literal >> 40) bitAnd: 16rFF);
				byteAt: base + 6 put: ((literal >> 48) bitAnd: 16rFF);
				byteAt: base + 7 put: ((literal >> 52) bitAnd: 16rFF)]