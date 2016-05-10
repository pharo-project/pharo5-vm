abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:.
	 Restore none, because the ARM ABI only defines callee saved registers, no caller-saved regs."
	^0