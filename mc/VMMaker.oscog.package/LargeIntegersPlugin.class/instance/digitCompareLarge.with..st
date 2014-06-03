oop functions
digitCompareLarge: firstInteger with: secondInteger 
	"Compare the magnitude of firstInteger with that of secondInteger.      
	Return a code of 1, 0, -1 for firstInteger >, = , < secondInteger"
	| firstLen secondLen |
	firstLen := self byteSizeOfBytes: firstInteger.
	secondLen := self byteSizeOfBytes: secondInteger.
	secondLen ~= firstLen
		ifTrue: [secondLen > firstLen
				ifTrue: [^ -1 asOop: SmallInteger]
				ifFalse: [^ 1 asOop: SmallInteger]].
	^ (self
		cDigitCompare: (interpreterProxy firstIndexableField: firstInteger)
		with: (interpreterProxy firstIndexableField: secondInteger)
		len: firstLen)
		asOop: SmallInteger