oop util
largeInt: aBytesObject growTo: newByteLen 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Does not normalize."
	| newBytes oldDigitLen newDigitLen copyLen |
	self remapOop: aBytesObject in: [newBytes := interpreterProxy instantiateClass: (interpreterProxy fetchClassOf: aBytesObject)
					indexableSize: newByteLen].
	newDigitLen := newByteLen + 3 // 4.
	oldDigitLen := self digitSizeOfLargeInt: aBytesObject.
	oldDigitLen < newDigitLen
		ifTrue: [copyLen := oldDigitLen]
		ifFalse: [copyLen := newDigitLen].
	self
		cDigitCopyFrom: (interpreterProxy firstIndexableField: aBytesObject)
		to: (interpreterProxy firstIndexableField: newBytes)
		len: copyLen.
	^ newBytes