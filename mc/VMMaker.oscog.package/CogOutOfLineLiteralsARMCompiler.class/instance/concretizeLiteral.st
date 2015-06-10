generate machine code
concretizeLiteral
	| literalAsInstruction literal |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	literalAsInstruction := cogit cCoerceSimple: (operands at: 0) to: #'AbstractInstruction *'.
	literal := (self isAnInstruction: literalAsInstruction)
				ifTrue: [literalAsInstruction address]
				ifFalse: [self cCode: [literalAsInstruction asUnsignedInteger]
							inSmalltalk: [literalAsInstruction]].
	self assert: (dependent notNil and: [dependent opcode = Literal and: [dependent address = address]]).
	self machineCodeAt: 0 put: literal