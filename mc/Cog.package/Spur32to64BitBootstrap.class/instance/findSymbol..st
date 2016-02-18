public access
findSymbol: aString
	"Find the Symbol equal to aString in oldHeap."
	| symbolClass |
	(literalMap at: aString ifAbsent: nil) ifNotNil:
		[:oop| ^oop].
	symbolClass := self symbolClass.
	heap64 allObjectsDo:
		[:obj|
		(symbolClass = (heap64 fetchClassOfNonImm: obj)
		 and: [(heap64 numBytesOf: obj) = aString size
		 and: [aString = (heap64 stringOf: obj)]]) ifTrue:
			[aString isSymbol ifTrue:
				[literalMap at: aString asSymbol put: obj].
			 ^obj]].
	Transcript cr; nextPutAll: 'Warning, could not find '; store: aString; flush.
	^nil