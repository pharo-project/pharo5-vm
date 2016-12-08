inline cacheing
literalBeforeFollowingAddress: followingAddress
	"Answer the literal embedded in the instruction immediately preceding followingAddress.
	 This is used in the MoveCwR, PushCw and ArithCwR cases; these are distinguished by a
	 nop following the literal load in MoveCwR, a 16r48 + reg ending the PushCw sequence, and
	 a (self mod: ModReg RM: rX RO: rY) ending the ArithCwR sequence, which is at least 16rC0."
	| lastByte base |
	lastByte := objectMemory byteAt: followingAddress - 1.
	base := followingAddress - (lastByte = 16r90
									ifTrue: [9]				"MoveCwR"
									ifFalse:
										[lastByte < 16r90
											ifTrue: [10]		"PushCw"
											ifFalse: [11]]).	"ArithCwR"
	^objectMemory unalignedLongAt: base
	
	"(Symbol allSymbols select: [:s| '*Cw:R:' match: s]), {#PushCw:} collect: [:s| {s. (self systemNavigation allCallsOn: s localToPackage: #VMMaker) size}]"