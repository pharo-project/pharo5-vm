abstract instructions
rewriteOpcode: anOpcode with: left with: right
	<inline: true>
	self assert: anOpcode isInteger.
	self assert: left isInteger.
	self assert: right isInteger.
	
	opcode := anOpcode.
	operands
		"0 is target"
		at: 1 put: left;
		at: 2 put: right