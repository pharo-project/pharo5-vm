translation
machineCodeDeclaration
	"Answer the declaration for the machineCode array.
	 MPIS instructions are 32-bits in length."
	^{#'unsigned int'. '[', self basicNew machineCodeWords printString, ']'}