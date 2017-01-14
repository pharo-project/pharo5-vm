compile abstract instructions
locateLiteral: aLiteral
	"Search for a Literal instruction that is in-range and answer it.  Otherwise
	 allocate a new sharable Literal instruction for the literal and answer it."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: false>
	| litInst |
	<var: 'litInst' type: #'AbstractInstruction *'>
	0 to: nextLiteralIndex - 1 do:
		[:i|
		litInst := self literalInstructionAt: i.
		((litInst operands at: 0) = aLiteral
		 and: [litInst isSharable
		 and: [self literalInstructionInRange: litInst]]) ifTrue:
			[^litInst]].
	nextLiteralIndex >= literalsSize ifTrue:
		[self allocateLiterals: literalsSize + 8].
	litInst := self literalInstructionAt: nextLiteralIndex.
	litInst initializeSharableLiteral: aLiteral.
	nextLiteralIndex := nextLiteralIndex + 1.
	"Record the opcodeIndex of the first dependent instruction (the first instruction that references an out-of-line literal)"
	firstOpcodeIndex > cogit getOpcodeIndex ifTrue:
		[firstOpcodeIndex := cogit getOpcodeIndex - 1].
	^litInst