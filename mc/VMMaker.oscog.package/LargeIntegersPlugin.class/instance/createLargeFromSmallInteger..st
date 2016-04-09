oop util
createLargeFromSmallInteger: anOop 
	"anOop has to be a SmallInteger!"
	| val res pDigit byteSize digitSize |
	<var: #pDigit type: #'unsigned int *'>
	val := interpreterProxy integerValueOf: anOop.
	byteSize := self byteSizeOfCSI: val.
	res := self createLargeIntegerNeg: val < 0 byteLength: byteSize.
	pDigit := self pointerToFirstDigitOfLargeInt: res.
	digitSize := byteSize + 3 // 4.
	1 to: digitSize do: [:ix | self cDigitOf: pDigit at: ix - 1 put: (self digitOfCSI: val at: ix)].
	^ res