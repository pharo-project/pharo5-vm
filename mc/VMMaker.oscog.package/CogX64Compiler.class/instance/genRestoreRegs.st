abi
genRestoreRegs
	"Restore the general purpose registers for a trampoline call.
	 c.f. genSaveRegisters"
	cogit
		PopR: RAX;
		PopR: RBX;
		PopR: RCX;
		PopR: RDX;
		PopR: RSI;
		PopR: RDI;
		PopR: R8;
		PopR: R9;
		PopR: R10;
		PopR: R11;
		PopR: R12;
		PopR: R13;
		PopR: R14;
		PopR: R15.
	^0