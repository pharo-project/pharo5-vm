*VMMaker-plugin generation
ccgDeclareCForVar: aSymbolOrString
	"Address of an unsigned 32 bit value, regardless of Smalltalk wordSize"

	^'unsigned *', aSymbolOrString