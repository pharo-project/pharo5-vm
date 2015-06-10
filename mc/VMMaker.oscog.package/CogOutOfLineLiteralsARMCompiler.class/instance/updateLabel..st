generate machine code
updateLabel: labelInstruction
	opcode ~= Literal ifTrue:
		[super updateLabel: labelInstruction]