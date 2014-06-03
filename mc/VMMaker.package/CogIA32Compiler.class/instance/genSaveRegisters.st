abi
genSaveRegisters
	"Save the general purpose registers for a trampoline call."
	cogit
		PushR: EDI;
		PushR: ESI;
		PushR: EDX;
		PushR: ECX;
		PushR: EBX;
		PushR: EAX.
	^0