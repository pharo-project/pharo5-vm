floating-point emulation
handleFPStatus: instr at: pc
	"Emulate transferring the FP status to the ARM CPSR."
	| fpcpsr |
	fpcpsr := self fpCPSR.
	self vflag: (fpcpsr bitAnd: 1).
	self cflag: ((fpcpsr >>1) bitAnd: 1).
	self zflag: ((fpcpsr >>2) bitAnd: 1).
	self nflag: ((fpcpsr >>3) bitAnd: 1).
	self pc: pc + 4