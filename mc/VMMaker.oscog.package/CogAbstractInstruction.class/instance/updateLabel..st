generate machine code
updateLabel: labelInstruction
	"Update an instruction that depends on a label outside of
	 generated code (e.g. a method or block header)."
	<var: #labelInstruction type: #'AbstractInstruction *'>
	| offsetAddress |
	offsetAddress := labelInstruction address + labelInstruction labelOffset.
	opcode caseOf: {
		[MoveCwR]		-> [operands at: 0 put: offsetAddress].
		[PushCw]		-> [operands at: 0 put: offsetAddress].
		[FillFromWord]	-> [operands at: 0 put: offsetAddress]}