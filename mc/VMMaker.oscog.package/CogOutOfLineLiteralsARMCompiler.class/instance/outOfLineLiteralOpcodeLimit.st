compile abstract instructions
outOfLineLiteralOpcodeLimit
	"The maximum offset in a LDR is 1<<12.  Be conservative."
	^1<<(11-2)