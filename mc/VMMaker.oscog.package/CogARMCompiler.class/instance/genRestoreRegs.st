abi
genRestoreRegs
	"Restore the general purpose registers for a trampoline call."
	"Restore none, because the ARM ABI only defines callee saved registers, no caller-saved regs."
	"cogit gen: LDMFD operand: 16r7F"