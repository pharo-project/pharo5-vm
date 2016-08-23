C translation
defineAtCompileTime: anObject
	"Override to define at translation time those variables that need to
	 be defined at compile time only in plugins, but not in the main VM,
	 because the VM generated is specific to these varables."
	anObject isSymbol ifFalse:
		[^false].
	(#(STACKVM COGVM COGMTVM SPURVM) includes: anObject) ifTrue:
		[^false].
	^VMBasicConstants namesDefinedAtCompileTime includes: anObject