oop functions
digit: anOop Lshift: shiftCount 
	"Attention: this method invalidates all oop's! Only newOop is valid at return."
	"Does not normalize."
	| newOop highBit newDigitLen newByteLen oldDigitLen |
	oldDigitLen := self digitSizeOfLargeInt: anOop.
	(highBit := self cDigitHighBit: (self pointerToFirstDigitOfLargeInt: anOop)
				len: oldDigitLen) = 0 ifTrue: [^  interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: anOop) indexableSize: 1].
	newByteLen := highBit + shiftCount + 7 // 8.
	self remapOop: anOop in:
		[newOop := interpreterProxy
						instantiateClass: (interpreterProxy fetchClassOf: anOop)
						indexableSize: newByteLen].
	newOop ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	newDigitLen := newByteLen + 3 // 4.
	self
		cDigitLshift: shiftCount
		from: (self pointerToFirstDigitOfLargeInt: anOop)
		len: oldDigitLen
		to: (self pointerToFirstDigitOfLargeInt: newOop)
		len: newDigitLen.
	^ newOop