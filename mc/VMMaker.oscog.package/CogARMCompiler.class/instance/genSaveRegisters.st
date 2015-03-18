abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."
	"Save none, because the ARM ABI only defines callee saved registers, no caller-saved regs."
	"cogit gen: STMFD operand: 16r7F"