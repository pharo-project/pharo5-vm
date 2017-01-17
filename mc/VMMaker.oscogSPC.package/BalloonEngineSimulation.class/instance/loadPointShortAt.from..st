simulation
loadPointShortAt: index from: intArray 
	"Load the short value from the given index in intArray"
	| long |
	long := intArray at: index // 2.
	long isPoint
		ifTrue: [^ (index bitAnd: 1)
					= 0
				ifTrue: [long x]
				ifFalse: [long y]].
	^ ((index bitAnd: 1)
			= 0
		ifTrue: [interpreterProxy halfWordHighInLong32: long]
		ifFalse: [interpreterProxy halfWordLowInLong32: long]) signedIntFromShort
