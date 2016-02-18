translation
machineCodeDeclaration
	"Answer the declaration for the machineCode array."
	^{#'unsigned long'. '[', self basicNew machineCodeWords printString, ']'}