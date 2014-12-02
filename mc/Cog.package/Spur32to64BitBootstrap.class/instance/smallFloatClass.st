bootstrap image
smallFloatClass
	| sf64sym |
	sf64sym := self findSymbol: #SmallFloat64.
	heap64 allObjectsDo:
		[:o|
		((heap64 isPointersNonImm: o)
		 and: [(heap64 numSlotsOf: o) > interpreter32 classNameIndex
		 and: [(interpreter64 addressCouldBeClassObj: o)
		 and: [(heap64 fetchPointer: interpreter32 classNameIndex ofObject: o) = sf64sym]]]) ifTrue:
			[^o]].
	^nil