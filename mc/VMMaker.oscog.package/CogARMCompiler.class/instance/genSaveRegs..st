abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline.
	 Save none, because the ARM ABI only defines callee saved registers, no caller-saved regs."
	^0