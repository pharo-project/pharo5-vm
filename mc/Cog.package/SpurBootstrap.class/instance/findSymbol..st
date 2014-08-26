bootstrap methods
findSymbol: aString
	"Find the Symbol equal to aString in oldHeap."
	| symbolClass |
	(literalMap at: aString ifAbsent: nil) ifNotNil:
		[:oop| ^oop].
	symbolClass := self symbolClass.
	oldHeap allObjectsDo:
		[:obj|
		(symbolClass = (oldHeap fetchClassOfNonImm: obj)
		 and: [(oldHeap numBytesOf: obj) = aString size
		 and: [aString = (oldHeap stringOf: obj)]]) ifTrue:
			[aString isSymbol ifTrue:
				[literalMap at: aString asSymbol put: obj].
			 ^obj]].
	Transcript cr; nextPutAll: 'Warning, could not find '; store: aString; flush.
	^nil