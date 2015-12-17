abi
genRestoreRegs
	"Restore the general purpose registers for a trampoline call.
	 c.f. genSaveRegisters"
	RAX to: R15 do:
		[:reg|
		 (reg between: RSP and: RBP) ifFalse:
			[cogit PopR: reg]].
	^0