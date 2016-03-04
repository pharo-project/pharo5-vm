abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:.
	 Restore none, because the ARM ABI only defines callee saved registers, no caller-saved regs.
	 But for the future..."
	self assert: regMask = 0.
	self deny: (regMask anyMask: (cogit registerMaskFor: SP and: FPReg and: LR and: PC)).
	R0 to: R12 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PopR: reg]].
	^0