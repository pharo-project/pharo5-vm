translation
tableInitializerFor: aTable in: aCCodeGenerator
	^String streamContents:
		[:s|
		s nextPutAll: ' = {'.
		aTable object
			do: [:gt|
				s crtab.
				gt printCInitializerOn: s in: aCCodeGenerator]
			separatedBy: [s nextPut: $,].
		s cr; nextPut: $}]