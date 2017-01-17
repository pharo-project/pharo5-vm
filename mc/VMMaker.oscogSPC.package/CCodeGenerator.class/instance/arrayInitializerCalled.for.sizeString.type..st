utilities
arrayInitializerCalled: varName for: array sizeString: sizeStringOrNil type: cType
	"array is a literal array or a CArray on some array."
	^String streamContents:
		[:s| | sequence lastLine index newLine allIntegers |
		sequence := array isCollection ifTrue: [array] ifFalse: [array object].
		"this is to align -ve and +ve integers nicely in the primitiveAccessorDepthTable"
		allIntegers := sequence allSatisfy: [:element| element isInteger].
		lastLine := index := 0.
		newLine := [sequence size >= 20
						ifTrue: [s cr; nextPutAll: '/*'; print: index; nextPutAll: '*/'; tab]
						ifFalse: [s crtab: 2].
					 lastLine := s position].
		s	nextPutAll: cType;
			space;
			nextPutAll: varName;
			nextPut: $[.
		sizeStringOrNil ifNotNil: [s nextPutAll: sizeStringOrNil].
		s nextPutAll: '] = '.
		sequence isString
			ifTrue: [s nextPutAll: (self cLiteralFor: sequence)]
			ifFalse:
				[s nextPut: ${.
				 newLine value.
				 sequence
					do: [:element|
						(allIntegers
						 and: [element < 0
						 and: [s peekLast = Character space]]) ifTrue:
							[s skip: -1].
						s nextPutAll: (self cLiteralFor: element). index := index + 1]
					separatedBy:
						[s nextPut: $,.
						 ((s position - lastLine) >= 76
						 or: [(index \\ 20) = 0])
							ifTrue: [newLine value]
							ifFalse: [s space]].
				 s crtab; nextPut: $}]]