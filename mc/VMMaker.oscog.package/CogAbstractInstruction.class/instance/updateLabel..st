generate machine code
updateLabel: labelInstruction
	"Update an instruction that depends on a label outside
	 of generated code (e.g. a method or block header)."
	<var: #labelInstruction type: #'AbstractInstruction *'>
	self assert: (opcode = MoveCwR or: [opcode = PushCw]).
	operands at: 0 put: labelInstruction address + labelInstruction labelOffset