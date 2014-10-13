utilities
bootstrapPharoImage: imageFileBaseName
	| oldCompilerClass oldBytecodeBackend |
	
	oldCompilerClass := SmalltalkImage compilerClass.
	oldBytecodeBackend := CompilationContext bytecodeBackend.
	[ 
		SmalltalkImage compilerClass: Compiler. 
		"CompilationContext bytecodeBackend: ."
		self bootstrapImage: imageFileBaseName type: 'pharo' ]
	ensure: [ 
		SmalltalkImage compilerClass: oldCompilerClass.
		CompilationContext bytecodeBackend: oldBytecodeBackend ]