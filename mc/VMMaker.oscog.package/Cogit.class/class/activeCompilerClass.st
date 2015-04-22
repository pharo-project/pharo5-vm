translation
activeCompilerClass
	^CogAbstractInstruction subclasses detect: [:compilerClass| compilerClass ISA == (initializationOptions at: #ISA)]