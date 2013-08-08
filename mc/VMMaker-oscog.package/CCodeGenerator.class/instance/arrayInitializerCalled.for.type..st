utilities
arrayInitializerCalled: varName for: array type: cType
	"array is a literal array or a CArray on some array."
	| sequence lastLine |
	sequence := array isCollection ifTrue: [array] ifFalse: [array object].
	lastLine := 0.
	^String streamContents:
		[:s|
		s	nextPutAll: cType;
			space;
			nextPutAll: varName;
			nextPutAll: '[] = '.
		sequence isString
			ifTrue: [s nextPutAll: (self cLiteralFor: sequence)]
			ifFalse:
				[s nextPut: ${; crtab: 2.
				sequence
					do: [:element| s nextPutAll: (self cLiteralFor: element)]
					separatedBy:
						[s nextPut: $,.
						 (s position - lastLine) > 76
							ifTrue: [s crtab: 2. lastLine := s position]
							ifFalse: [s space]].
				s crtab; nextPut: $}].
		s cr]