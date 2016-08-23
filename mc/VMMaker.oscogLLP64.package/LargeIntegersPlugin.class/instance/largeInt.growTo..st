oop util
largeInt: aBytesObject growTo: newByteLen 
	"Attention: this method invalidates all oop's! Only newBytes is valid at return."
	"Does not normalize."
	| newBytes oldDigitLen newDigitLen copyLen |
	self remapOop: aBytesObject in:
		[newBytes := interpreterProxy
						instantiateClass: (interpreterProxy fetchClassOf: aBytesObject)
						indexableSize: newByteLen].
	newBytes ifNil: [^interpreterProxy primitiveFailFor: PrimErrNoMemory].
	newDigitLen := newByteLen + 3 // 4.
	oldDigitLen := self digitSizeOfLargeInt: aBytesObject.
	copyLen := oldDigitLen < newDigitLen
					ifTrue: [oldDigitLen]
					ifFalse: [newDigitLen].
	self
		cDigitCopyFrom: (self pointerToFirstDigitOfLargeInt: aBytesObject)
		to: (self pointerToFirstDigitOfLargeInt: newBytes)
		len: copyLen.
	^newBytes