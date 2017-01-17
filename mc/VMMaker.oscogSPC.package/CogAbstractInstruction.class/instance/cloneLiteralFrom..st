initialization
cloneLiteralFrom: existingLiteral
	"For out-of-line literal support, clone a literal from a literal."
	<var: 'existingLiteral' type: #'AbstractInstruction *'>
	self assert: (existingLiteral opcode = Literal and: [dependent isNil and: [address isNil]]).
	opcode := Literal.
	annotation := existingLiteral annotation.
	operands
		at: 0 put: (existingLiteral operands at: 0);
		at: 1 put: (existingLiteral operands at: 1);
		at: 2 put: (existingLiteral operands at: 2)