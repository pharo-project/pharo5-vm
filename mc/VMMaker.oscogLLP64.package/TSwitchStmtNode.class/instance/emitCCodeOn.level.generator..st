C code generation
emitCCodeOn: aStream level: level generator: aCodeGen

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
		  case emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
		  case endsWithReturn ifFalse:
			[aStream tab: level + 1; nextPutAll: 'break;']]
			valueWithArguments: tuple].
	aStream
		crtab: level;
		nextPutAll: 'default:';
		crtab: level + 1.
	otherwiseOrNil
		ifNotNil:
			[otherwiseOrNil emitCCodeOn: aStream level: level + 1 generator: aCodeGen.
			(self stream: aStream endsWithAnyOf: '};') ifFalse:
				[aStream nextPut: $;]]
		ifNil: [aStream nextPutAll: 'error("Case not found and no otherwise clause");'].
	aStream
		crtab: level;
		nextPut: $}