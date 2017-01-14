translation
machineCodeDeclaration
	"Answer the declaration for the machineCode array."
	^{#'unsigned char'. '[', self basicNew machineCodeBytes printString, ']'}