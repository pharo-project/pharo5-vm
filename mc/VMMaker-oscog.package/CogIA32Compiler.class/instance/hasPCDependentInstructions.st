testing
hasPCDependentInstructions
	"Answer whether the concrete machine code contains pc-dependent
	 instructions, such as the IA32/x86's short and long relative jumps
	 and the EMT64/x86-64's pc-relative addressing mode.  Such
	 instructions require an extra pass to generate them correctly."
	^true