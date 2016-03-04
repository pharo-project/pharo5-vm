abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline.
	 Save none, because the ARM ABI only defines callee saved registers, no caller-saved regs.
	 But for the future..."
	self assert: regMask = 0.
	self deny: (regMask anyMask: (cogit registerMaskFor: SP and: FPReg and: LR and: PC)).
	R12 to: R0 by: -1 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PushR: reg]].
	^0