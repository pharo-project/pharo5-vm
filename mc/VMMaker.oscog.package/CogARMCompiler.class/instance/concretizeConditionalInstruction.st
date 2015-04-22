generate machine code
concretizeConditionalInstruction
	"Concretize the current instruction, but with a condition."
	<returnTypeC: #void>
	| savedCond |
	self assert: cond notNil.
	savedCond := cond.
	cond := nil.
	self dispatchConcretize.
	cond := savedCond.
	0 to: machineCodeSize-1 by: 4 do:
		[:i| | instr |
		instr := (self machineCodeAt: i) bitClear: 16rF<<28.
		self machineCodeAt: i put: (instr bitOr: (cond bitAnd: 16rF)<<28)]