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
				[| defaultExpr type |
				 aStream crtab: level + 1.
				 defaultExpr := TConstantNode new setValue: -1.
				 (aNodeOrNil isAssignment
				  and: [(type := aCodeGen typeFor: aNodeOrNil variable in: aCodeGen currentMethod) notNil
				  and: [aCodeGen isPointerCType: type]]) ifTrue:
					[defaultExpr := TSendNode new
										setSelector: #cCoerceSimple:to:
										receiver: (TVariableNode new setName: 'self')
										arguments: {defaultExpr. TConstantNode new setValue: type}].
				 (aNodeOrNil copy setExpression: defaultExpr)
					emitCCodeOn: aStream level: level generator: aCodeGen.
				 aStream nextPut: $;]].
	aStream
		crtab: level;
		nextPut: $}