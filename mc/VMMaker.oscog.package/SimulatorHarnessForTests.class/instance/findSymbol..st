utilities
findSymbol: aString
	"Find the Symbol equal to aString in oldHeap."
	| om size symbolClassTag |
	symbolClassTag := (om := simulator objectMemory) rawClassTagForClass: self symbolClass.
	size := aString size.
	om allObjectsDo:
		[:obj|
		(symbolClassTag = (om fetchClassTagOfNonImm: obj)
		 and: [(om numBytesOf: obj) = size
		 and: ["(om fetchByte: 0 ofObject: obj) asCharacter == $C ifTrue:
				[simulator printOopShort: obj; halt]."
			(om str: aString n: obj + om baseHeaderSize cmp: size) = 0]]) ifTrue:
			[^obj]].
	^nil