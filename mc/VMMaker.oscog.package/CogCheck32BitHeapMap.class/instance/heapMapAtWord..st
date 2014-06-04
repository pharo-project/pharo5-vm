accessing
heapMapAtWord: address
	"answer the bit corresponding to address aBit in the map"
	^(pages at: (self pageIndex: address))
		ifNil: [0]
		ifNotNil:
			[:page|
			((page at: (self byteIndex: address))
				bitShift: 0 - (self bitIndex: address))
					bitAnd: 1]