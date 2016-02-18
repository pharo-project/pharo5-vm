accessing
jmpTarget: anAbstractInstruction
	"Set the target of a jump instruction.  These all have the target in the first operand."
	<returnTypeC: #'AbstractInstruction *'>
	<var: #anAbstractInstruction type: #'AbstractInstruction *'>
	self cCode: [] "check for inadvertent smashing of already-set jmpTargets; development only"
		inSmalltalk: [self assert: ((operands at: 0)
									ifNil: [true]
									ifNotNil: [:o|
											o = 0
											or: [(self isAFixup: o)
											or: [self isAnInstruction: anAbstractInstruction]]])].
	operands at: 0 put: anAbstractInstruction asUnsignedInteger.
	^anAbstractInstruction