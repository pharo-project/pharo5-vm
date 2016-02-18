C code generation
emitCCodeOn: aStream level: level generator: aCodeGen
	"Emit a C comment with optional label."

	self printOptionalLabelOn: aStream.
	comment ifNotNil:
		[(aCodeGen previousCommentMarksInlining: (label isNil and: [asmLabel isNil and: [comment beginsWith: 'begin ']])) ifTrue:
			[^true].
		 aStream nextPutAll: '/* '; nextPutAll: comment; nextPutAll: ' */'.
		 aCodeGen previousCommenter: self].
	(asmLabel notNil "only output labels in the interpret function."
	 and: [aCodeGen currentMethod selector == #interpret]) ifTrue:
		[aStream crtab: level.
		 aCodeGen outputAsmLabel: asmLabel on: aStream]