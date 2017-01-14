class initialization
initialize
	"Initialize the fixup flags.  In this class we have only one flag, 1, which
	 means set the fixup to point to the first instruction for a particular bytecode.
	 A forward branch from one bytecode to a later one will set its jmpTarget to
	 a fixup.  later, in compileAbstractInstructionsFrom:to:, any fixup with its
	 targetInstruction set to NeedsFixupFlag will have its targetInstruction set
	 to the first bytecode of the sequence.  Later still, when code is generated
	 jumps follow fixups to eliminate the fixup and target the rigth instruction."
	NeedsFixupFlag := 1