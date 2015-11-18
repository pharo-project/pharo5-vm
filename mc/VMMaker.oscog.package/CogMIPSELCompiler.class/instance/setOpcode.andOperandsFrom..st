accessing
setOpcode: anOpcode andOperandsFrom: cmpInstruction
	<var: #cmpInstruction type: #'AbstractInstruction *'>
	<inline: true>
	opcode := anOpcode.
	operands
		at: 0 put: (cmpInstruction opcodes at: 0);
		at: 1 put: (cmpInstruction opcodes at: 1)