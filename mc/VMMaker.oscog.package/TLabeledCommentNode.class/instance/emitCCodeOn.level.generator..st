C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	comment ifNotNil:
		[aStream nextPutAll: '/* '.
		 aStream nextPutAll: comment.
		 aStream nextPutAll: ' */'].
	(asmLabel notNil "only output labels in the interpret function."
	 and: [aCodeGen currentMethod selector == #interpret]) ifTrue:
		[aStream crtab: level.
		 aCodeGen outputAsmLabel: asmLabel on: aStream]