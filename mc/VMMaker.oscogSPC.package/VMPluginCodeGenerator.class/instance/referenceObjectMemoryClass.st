C code generator
referenceObjectMemoryClass
	"Define the class from which to take methods to define the interpreter proxy imports."
	^(Smalltalk classNamed: #SpurMemoryManager) ifNil:
		[(Smalltalk classNamed: #NewObjectMemory) ifNil:
			[ObjectMemory]]