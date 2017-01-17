translation
activeCompilerClass
	^initializationOptions
		at: #CogCompilerClass
		ifPresent: [:compilerClassName| Smalltalk classNamed: compilerClassName]
		ifAbsent:
			[(CogAbstractInstruction subclasses detect:
				[:compilerClass|
				 compilerClass ISA == (initializationOptions at: #ISA ifAbsent: [#IA32])]) defaultCompilerClass]