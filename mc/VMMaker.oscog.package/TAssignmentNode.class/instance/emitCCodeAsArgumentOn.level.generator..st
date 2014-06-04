C code generation
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	aStream nextPut: $(.
	self emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream nextPut: $)