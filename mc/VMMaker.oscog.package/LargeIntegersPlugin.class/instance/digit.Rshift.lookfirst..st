oop functions
digit: anOop Rshift: shiftCount lookfirst: a 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Shift right 32*digitShift+bitShift bits, 0<=bitShift<32.         
	Discard all digits beyond a, and all zeroes at or below a."
	"Does not normalize."
	| newByteLen newOop oldBitLen newBitLen oldDigitLen newDigitLen |
	oldBitLen := self cDigitHighBit: (self pointerToFirstDigitOfLargeInt: anOop) len: a.
	oldDigitLen := oldBitLen + 31 // 32.
	newBitLen := oldBitLen - shiftCount.
	newBitLen <= 0 ifTrue: ["All bits lost"
		^ interpreterProxy
			instantiateClass: (interpreterProxy fetchClassOf: anOop)
			indexableSize: 0].
	newByteLen := newBitLen + 7 // 8.
	newDigitLen := newByteLen + 3 // 4.
	self remapOop: anOop in:
		[newOop := interpreterProxy
						instantiateClass: (interpreterProxy fetchClassOf: anOop)
						indexableSize: newByteLen].
	newOop ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	self
		cDigitRshift: shiftCount
		from: (self pointerToFirstDigitOfLargeInt: anOop)
		len: oldDigitLen
		to: (self pointerToFirstDigitOfLargeInt: newOop)
		len: newDigitLen.
	^ newOop