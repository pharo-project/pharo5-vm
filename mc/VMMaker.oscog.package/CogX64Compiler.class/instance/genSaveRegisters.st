abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."
	cogit
		PushR: R15;
		PushR: R14;
		PushR: R13;
		PushR: R12;
		PushR: R11;
		PushR: R10;
		PushR: R9;
		PushR: R8;
		PushR: RDI;
		PushR: RSI;
		PushR: RDX;
		PushR: RCX;
		PushR: RBX;
		PushR: RAX.
	^0