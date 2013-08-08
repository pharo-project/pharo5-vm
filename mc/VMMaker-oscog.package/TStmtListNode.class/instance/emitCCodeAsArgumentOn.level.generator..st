C code generation
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen

	| statementWasComment |
	statements size = 1 ifTrue:
		[^statements first emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen].
	statementWasComment := false.
	aStream nextPut: $(. "N.B.  Comma binds weakest of all C operators."
	statements
		do:
			[:s |
			s emitCCommentOn: aStream level: level.
			s emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			statementWasComment := s isComment]
		separatedBy:
			[((self endsWithCloseBracket: aStream)
			  or: [statementWasComment]) ifFalse: [aStream nextPut: $,].
			aStream crtab: level].
	aStream nextPut: $)