testing
insert32BitOperand: operand into4InstructionsPreceding: addr
	<inline: true>
	objectMemory
		byteAt: addr -   4 put: (operand			bitAnd: 16rFF);
		byteAt: addr -   8 put: (operand >>   8	bitAnd: 16rFF);
		byteAt: addr - 12 put: (operand >> 16	bitAnd: 16rFF);
		byteAt: addr - 16 put: (operand >> 24	bitAnd: 16rFF)