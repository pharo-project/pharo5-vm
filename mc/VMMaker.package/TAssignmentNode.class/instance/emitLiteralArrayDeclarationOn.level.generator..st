C code generation
emitLiteralArrayDeclarationOn: aStream level: level generator: aCCodeGen
	| type |
	type := expression args last value.
	self assert: type last = $*.
	aStream
		crtab: level;
		nextPutAll: '{ static ';
		nextPutAll: (aCCodeGen
						arrayInitializerCalled: 'aLiteralArray'
						for: expression args first value
						sizeString: nil
						type: type allButLast) withBlanksTrimmed;
		nextPut: $;;
		crtab: level + 1;
		nextPutAll: variable name;
		nextPutAll: ' = aLiteralArray;';
		crtab: level;
		nextPut: $};
		cr