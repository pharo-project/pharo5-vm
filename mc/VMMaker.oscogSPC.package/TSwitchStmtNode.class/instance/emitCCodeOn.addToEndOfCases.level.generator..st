C code generation
emitCCodeOn: aStream addToEndOfCases: aNodeOrNil level: level generator: aCodeGen

	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'.
	cases do:
		[:tuple|
		 [:labels :case|
		  labels do:
			[:label|
			 aStream
				crtab: level;
				nextPutAll: 'case '.
			label emitCCodeAsArgumentOn: aStream level: level + 1 generator: aCodeGen.
			aStream nextPut: $:].
		  aStream crtab: level + 1.
		  case emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
			valueWithArguments: tuple.
		  (aNodeOrNil notNil and: [aNodeOrNil isReturn]) ifFalse:
			[aStream crtab: level + 1; nextPutAll: 'break;']].
	aStream
		crtab: level;
		nextPutAll: 'default:';
		crtab: level + 1.
	otherwiseOrNil
		ifNotNil: [otherwiseOrNil emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'.
			   aNodeOrNil ifNotNil:
				[aStream crtab: level + 1.
				 (aNodeOrNil copy setExpression: (TConstantNode new setValue: -1))
					emitCCodeOn: aStream level: level generator: aCodeGen.
				 aStream nextPut: $;]].
	aStream
		crtab: level;
		nextPut: $}