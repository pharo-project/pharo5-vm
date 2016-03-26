oop util
createLargeFromSmallInteger: anOop 
	"anOop has to be a SmallInteger!"
	| val class size res pByte byte |
	<var: #pByte type: #'unsigned char *'>
	val := interpreterProxy integerValueOf: anOop.
	val < 0
		ifTrue: [class := interpreterProxy classLargeNegativeInteger]
		ifFalse: [class := interpreterProxy classLargePositiveInteger].
	size := self cDigitLengthOfCSI: val.
	res := interpreterProxy instantiateClass: class indexableSize: size.
	pByte := interpreterProxy firstIndexableField: res.
	1 to: size do: [:ix |
		byte := self cDigitOfCSI: val at: ix.
		pByte at: ix - 1 put: byte].
	^res