Author useAuthor: 'SpurBootstrap' during: [
	SmalltalkImage compilerClass: OpalCompiler. 
	CompilationContext bytecodeBackend: IRSpurSqueakV3PlusClosuresBytecodeGenerator.
].
Smalltalk snapshot: true andQuit: true.
