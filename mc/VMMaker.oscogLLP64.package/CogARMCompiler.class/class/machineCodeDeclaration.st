translation
machineCodeDeclaration
	"Answer the declaration for the machineCode array."
	^{#'usqIntptr_t'. '[', self basicNew machineCodeWords printString, ']'}