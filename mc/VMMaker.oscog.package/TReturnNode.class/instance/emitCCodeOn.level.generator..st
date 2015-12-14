C code generation
emitCCodeOn: aStream level: level generator: aCodeGen

	(expression isSwitch
	 or: [expression isCaseStmt]) ifTrue:
		[^expression emitCCodeOn: aStream addToEndOfCases: self level: level generator: aCodeGen].

	(expression isSend and: [expression isValueExpansion]) ifTrue:
		[^self emitValueExpansionOn: aStream level: level generator: aCodeGen].

	'void' = aCodeGen currentMethod returnType ifTrue: "If the function is void, don't say 'return x' instead say ' x; return' "
		[expression isLeaf ifFalse:
			[expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.	
			 aStream nextPut: $;; crtab: level].
		 aStream nextPutAll: 'return'.
		 ^self].
	aStream nextPutAll: 'return '.
	expression
		emitCCodeAsArgumentOn: aStream
		level: (expression isStmtList ifTrue: [level + 1] ifFalse: [level])
		generator: aCodeGen