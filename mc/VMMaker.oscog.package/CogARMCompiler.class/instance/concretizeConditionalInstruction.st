generate machine code
concretizeConditionalInstruction
	"Concretize the current instruction, but with a condition."
	<returnTypeC: #void>
	| savedCond |
	self assert: conditionOrNil notNil.
	savedCond := conditionOrNil.
	conditionOrNil := nil.
	self dispatchConcretize.
	conditionOrNil := savedCond.
	0 to: machineCodeSize-1 by: 4 do:
		[:i| | instr |
		instr := (self machineCodeAt: i) bitClear: 16rF<<28.
		self machineCodeAt: i put: (instr bitOr: (conditionOrNil bitAnd: 16rF)<<28)]