inline cacheing
storeLiteral: literal beforeFollowingAddress: followingAddress
	"Rewrite the literal in the instruction immediately preceding followingAddress.
	 This is used in the MoveCwR, PushCw and CmpCwR cases; these are distinguished by a
	 nop following the literal load in MoveCwR, a 16r50 + reg ending the PushCw sequence, and
	 a (self mod: ModReg RM: rX RO: rY) ending the CmpCwR sequence, which is at least 16rC0."
	| lastByte base |
	lastByte := objectMemory byteAt: followingAddress - 1.
	base := followingAddress - (lastByte <= 16r90
									ifTrue:
										[lastByte = 16r90
											ifTrue: [9]		"MoveCwR"
											ifFalse: [10]]	"PushCw"
									ifFalse: [11]).			"ArithCwR"
	objectMemory unalignedLongAt: base put: literal