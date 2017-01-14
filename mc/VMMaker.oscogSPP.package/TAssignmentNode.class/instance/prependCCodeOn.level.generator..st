C code generation
prependCCodeOn: aStream level: level generator: aCodeGen
	variable emitCCodeOn: aStream level: level generator: aCodeGen.
	aStream
		space;
		nextPutAll: (self isVariableUpdatingAssignment
						ifTrue: [expression selector "+ or -"]
						ifFalse: ['']);
		nextPut: $=;
		space