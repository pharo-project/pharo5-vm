oop functions
digitCompareLarge: firstInteger with: secondInteger 
	"Compare the magnitude of firstInteger with that of secondInteger.      
	Return a code of 1, 0, -1 for firstInteger >, = , < secondInteger"
	| firstDigitLen secondDigitLen |
	firstDigitLen := self digitSizeOfLargeInt: firstInteger.
	secondDigitLen := self digitSizeOfLargeInt: secondInteger.
	secondDigitLen ~= firstDigitLen
		ifTrue: [secondDigitLen > firstDigitLen
				ifTrue: [^ -1 asOop: SmallInteger]
				ifFalse: [^ 1 asOop: SmallInteger]].
	^ (self
		cDigitCompare: (self pointerToFirstDigitOfLargeInt: firstInteger)
		with: (self pointerToFirstDigitOfLargeInt: secondInteger)
		len: firstDigitLen)
		asOop: SmallInteger