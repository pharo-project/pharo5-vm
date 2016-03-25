oop functions
digit: aBytesOop Lshift: shiftCount 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Does not normalize."
	| newBytes highBit newLen oldLen |
	oldLen := self digitSizeOfLargeInt: aBytesOop.
	(highBit := self cDigitHighBit: (interpreterProxy firstIndexableField: aBytesOop)
				len: oldLen) = 0 ifTrue: [^ 0 asOop: SmallInteger].
	newLen := highBit + shiftCount + 7 // 8.
	self remapOop: aBytesOop in: [newBytes := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesOop)
					indexableSize: newLen].
	self
		cDigitLshift: shiftCount
		from: (interpreterProxy firstIndexableField: aBytesOop)
		len: oldLen
		to: (interpreterProxy firstIndexableField: newBytes)
		len: newLen.
	^ newBytes