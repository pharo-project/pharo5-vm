C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C literal."
	aStream nextPutAll: (aCodeGen cLiteralFor: value).
	comment ifNotNil:
		[aStream
			nextPutAll: ' /* ';
			nextPutAll: comment;
			nextPutAll: ' */']