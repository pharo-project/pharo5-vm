oop functions
digit: anOop Lshift: shiftCount 
	"Attention: this method invalidates all oop's! Only newOop is valid at return."
	"Does not normalize."
	| newOop highBit newDigitLen newByteLen oldDigitLen |
	oldDigitLen := self digitSizeOfLargeInt: anOop.
	(highBit := self cDigitHighBit: (interpreterProxy firstIndexableField: anOop)
				len: oldDigitLen) = 0 ifTrue: [^  interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: anOop) indexableSize: 1].
	newByteLen := highBit + shiftCount + 7 // 8.
	self remapOop: anOop in: [newOop := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: anOop)
					indexableSize: newByteLen].
	newDigitLen := newByteLen + 3 // 4.
	self
		cDigitLshift: shiftCount
		from: (interpreterProxy firstIndexableField: anOop)
		len: oldDigitLen
		to: (interpreterProxy firstIndexableField: newOop)
		len: newDigitLen.
	^ newOop