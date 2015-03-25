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
	3 to: machineCodeSize by: 4 do:
		[:i| | topByte |
		 topByte := machineCode at: i.
		 self assert: (topByte bitClear: 15) = 0.
		 machineCode at: i put: cond << 4 + topByte]