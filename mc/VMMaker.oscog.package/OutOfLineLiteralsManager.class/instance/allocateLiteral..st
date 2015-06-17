compile abstract instructions
allocateLiteral: aLiteral
	"Allocate a n unsharable Literal instruction for the literal and answer it."
	<returnTypeC: #'AbstractInstruction *'>
	<inline: true>
	| litInst |
	<var: 'litInst' type: #'AbstractInstruction *'>
	nextLiteralIndex >= literalsSize ifTrue:
		[self allocateLiterals: literalsSize + 8].
	litInst := self literalInstructionAt: nextLiteralIndex.
	litInst
		opcode: Literal;
		operand0: aLiteral;
		setIsUnique;
		setLiteralOpcodeIndex: -1. "means as-yet-unassigned; see literalInstructionInRange:"
	nextLiteralIndex := nextLiteralIndex + 1.
	"Record the opcodeIndex of the first dependent instruction (the first instruction that references an out-of-line literal)"
	firstOpcodeIndex > cogit getOpcodeIndex ifTrue:
		[firstOpcodeIndex := cogit getOpcodeIndex - 1].
	^litInst