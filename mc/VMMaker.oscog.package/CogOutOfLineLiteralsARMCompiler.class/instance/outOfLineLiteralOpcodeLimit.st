compile abstract instructions
outOfLineLiteralOpcodeLimit
	"The maximum offset in a LDR is (1<<12)-1, or (1<<10)-1 instructions.
	 Be a little conservative."
	^1<<(12-2) - 4