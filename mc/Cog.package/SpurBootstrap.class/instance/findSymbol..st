bootstrap methods
findSymbol: aString
	"Find the Symbol equal to aString in oldHeap."
	| symbolClass |
	symbolClass := self symbolClass.
	oldHeap allObjectsDo:
		[:o|
		(symbolClass = (oldHeap fetchClassOfNonImm: o)
		 and: [(oldHeap byteLengthOf: o) = aString size
		 and: [aString = (oldHeap stringOf: o)]]) ifTrue:
			[^o]].
	^nil