abi
genRestoreRegisters
	"Load the general purpose registers after the return of a trampoline call."
	"Because no registers were saved we don't restore any."
	"cogit
		gen: LDMFD operand: 16r7F"