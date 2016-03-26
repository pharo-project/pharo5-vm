oop functions
digit: aBytesOop Rshift: shiftCount lookfirst: a 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Shift right shiftCount bits, 0<=shiftCount.         
	Discard all digits beyond a, and all zeroes at or below a."
	"Does not normalize."
	| newByteLen newOop oldBitLen newBitLen oldDigitLen |
	oldBitLen := self cDigitHighBit: (interpreterProxy firstIndexableField: aBytesOop) len: a.
	oldDigitLen := oldBitLen + 7 // 8.
	newBitLen := oldBitLen - shiftCount.
	newBitLen <= 0 ifTrue: ["All bits lost"
		^ interpreterProxy
			instantiateClass: (interpreterProxy fetchClassOf: aBytesOop)
			indexableSize: 0].
	newByteLen := newBitLen + 7 // 8.
	self remapOop: aBytesOop in: [newOop := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesOop)
					indexableSize: newByteLen].
	self
		cDigitRshift: shiftCount
		from: (interpreterProxy firstIndexableField: aBytesOop)
		len: oldDigitLen
		to: (interpreterProxy firstIndexableField: newOop)
		len: newByteLen.
	^ newOop