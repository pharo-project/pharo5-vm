abi
genRestoreRegsExcept: abstractReg
	"Restore the general purpose registers except for abstractReg for a trampoline call."
	"Restore none, because the ARM ABI only defines callee saved registers, no caller-saved regs."
