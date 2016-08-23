C code generation
emitCCodeOn: aStream addToEndOfCases: aNodeOrNil level: level generator: aCodeGen

	| indent |
	indent := String new: level withAll: Character tab.
	aStream crtab: level.
	aStream nextPutAll: 'switch ('.
	expression emitCCodeAsArgumentOn: aStream level: level generator: aCodeGen.
	aStream nextPutAll: ') {'; cr.
	cases withIndexDo:
		[:case :i|
		(firsts at: i) to: (lasts at: i) do:
			[ :caseIndex |
			aStream nextPutAll: indent; nextPutAll: 'case '; print: caseIndex; nextPut: $:; cr].
		  case emitCCodeOn: aStream prependToEnd: aNodeOrNil level: level + 1 generator: aCodeGen.
		  (aNodeOrNil notNil and: [aNodeOrNil isReturn]) ifFalse:
			[aStream crtab: level + 1; nextPutAll: 'break;']].
	aStream
		crtab: level;
		nextPutAll: 'default:';
		crtab: level + 1;
		nextPutAll: 'error("Case not found");'.
	aNodeOrNil ifNotNil:
		[aStream crtab: level + 1.
		 (aNodeOrNil copy setExpression: (TConstantNode new setValue: -1))
			emitCCodeOn: aStream level: level generator: aCodeGen.
		 aStream nextPut: $;].
	aStream
		crtab: level;
		nextPut: $}