C code generation
emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen
	| size |
	(size := statements size) = 1 ifTrue:
		[^statements first emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen].
	aStream nextPut: $(. "N.B.  Comma binds weakest of all C operators."
	statements withIndexDo:
		[:s :idx| | p1 p2 |
		p1 := aStream position.
		s emitCCommentOn: aStream level: level generator: aCodeGen.
		(s isLeaf and: [s isLabel not and: [idx < statements size]]) ifFalse:
			[s emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen].
		p2 := aStream position.
		(idx < size and: [p2 > p1]) ifTrue:
			[((self endsWithCloseBracket: aStream)
			  or: [s isComment]) ifFalse: [aStream nextPut: $,].
			 aStream crtab: level]].
	aStream nextPut: $)