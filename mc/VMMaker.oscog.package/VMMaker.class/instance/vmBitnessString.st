target directories
vmBitnessString
	"Return a string of 32 or 64 depending on the is64BitVM valuse"
	^is64BitVM ifTrue:['64'] ifFalse:['32']