C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C goto statement."

	aStream nextPutAll: 'goto '.
	aStream nextPutAll: label.