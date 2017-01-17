testing
usesOutOfLineLiteral
	"Answer if the receiver uses an out-of-line literal.  Needs only
	 to work for the opcodes created with gen:literal:operand: et al."

	opcode
		caseOf: {
		[CallFull]		-> [^true].
		[JumpFull]		-> [^true].
		"Arithmetic"
		[AddCqR]		-> [^self rotateable8bitSignedImmediate: (operands at: 0) ifTrue: [:r :i :n| false] ifFalse: [true]].
		[AndCqR]		-> [^self rotateable8bitBitwiseImmediate: (operands at: 0)
								ifTrue: [:r :i :n| false]
								ifFalse: [1 << (operands at: 0) highBit ~= ((operands at: 0) + 1)]].
		[AndCqRR]		-> [^self rotateable8bitBitwiseImmediate: (operands at: 0)
								ifTrue: [:r :i :n| false]
								ifFalse: [1 << (operands at: 0) highBit ~= ((operands at: 0) + 1)]].
		[CmpCqR]		-> [^self rotateable8bitSignedImmediate: (operands at: 0) ifTrue: [:r :i :n| false] ifFalse: [true]].
		[OrCqR]			-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		[SubCqR]		-> [^self rotateable8bitSignedImmediate: (operands at: 0) ifTrue: [:r :i :n| false] ifFalse: [true]].
		[TstCqR]		-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		[XorCqR]		-> [^self rotateable8bitBitwiseImmediate: (operands at: 0) ifTrue: [:r :i :n| false] ifFalse: [true]].
		[AddCwR]		-> [^true].
		[AndCwR]		-> [^true].
		[CmpCwR]		-> [^true].
		[OrCwR]		-> [^true].
		[SubCwR]		-> [^true].
		[XorCwR]		-> [^true].
		[LoadEffectiveAddressMwrR]
						-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		"Data Movement"						
		[MoveCqR]		-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		[MoveCwR]		-> [^(self inCurrentCompilation: (operands at: 0)) not].
		[MoveAwR]		-> [^(self isAddressRelativeToVarBase: (operands at: 0)) ifTrue: [false] ifFalse: [true]].
		[MoveRAw]		-> [^(self isAddressRelativeToVarBase: (operands at: 1)) ifTrue: [false] ifFalse: [true]].
		[MoveAbR]		-> [^(self isAddressRelativeToVarBase: (operands at: 0)) ifTrue: [false] ifFalse: [true]].
		[MoveRAb]		-> [^(self isAddressRelativeToVarBase: (operands at: 1)) ifTrue: [false] ifFalse: [true]].
		[MoveRMwr]	-> [^self is12BitValue: (operands at: 1) ifTrue: [:u :i| false] ifFalse: [true]].
		[MoveRdM64r]	-> [^self is12BitValue: (operands at: 1) ifTrue: [:u :i| false] ifFalse: [true]]. 
		[MoveMbrR]		-> [^self is12BitValue: (operands at: 0) ifTrue: [:u :i| false] ifFalse: [true]].
		[MoveRMbr]		-> [^self is12BitValue: (operands at: 1) ifTrue: [:u :i| false] ifFalse: [true]].
		[MoveM16rR]	-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		[MoveRM16r]	-> [^self is12BitValue: (operands at: 1) ifTrue: [:u :i| false] ifFalse: [true]].
		[MoveM64rRd]	-> [^self is12BitValue: (operands at: 0) ifTrue: [:u :i| false] ifFalse: [true]].
		[MoveMwrR]	-> [^self is12BitValue: (operands at: 0) ifTrue: [:u :i| false] ifFalse: [true]].
		[PushCw]		-> [^(self inCurrentCompilation: (operands at: 0)) not].
		[PushCq]		-> [^self rotateable8bitImmediate: (operands at: 0) ifTrue: [:r :i| false] ifFalse: [true]].
		[PrefetchAw] 	-> [^(self isAddressRelativeToVarBase: (operands at: 0)) ifTrue: [false] ifFalse: [true]].
		}
		otherwise: [self assert: false].
	^false "to keep C compiler quiet"
