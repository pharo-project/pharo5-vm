C code generator
cLiteralFor: anObject name: smalltalkName
	"Return a string representing the C literal value for the given object.
	 This version may use hex for integers that are bit masks."
	anObject isInteger ifTrue:
		[| hex dec useHexa |
		hex := anObject printStringBase: 16.
		dec := anObject printStringBase: 10.
		useHexa := ((smalltalkName endsWith: 'Mask')
				or: [anObject digitLength > 1
					and: [(hex asSet size * 3) <= (dec asSet size * 2)
					and: [(smalltalkName endsWith: 'Size') not]]]).
		^self cLiteralForInteger: anObject hex: useHexa].
	^self cLiteralFor: anObject