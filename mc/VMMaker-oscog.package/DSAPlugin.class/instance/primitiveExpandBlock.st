primitives-SHA
primitiveExpandBlock
	"Expand a 64 byte ByteArray (the first argument) into and an Bitmap of 80 32-bit words (the second argument). When reading a 32-bit integer from the ByteArray, consider the first byte to contain the most significant bits of the word (i.e., use big-endian byte ordering)."

	| expanded buf wordPtr bytePtr src v |
	<export: true>
	<var: #wordPtr type: 'unsigned int *'>
	<var: #bytePtr type: 'unsigned char *'>

	expanded := interpreterProxy stackObjectValue: 0.
	buf := interpreterProxy stackObjectValue: 1.
	interpreterProxy success: (interpreterProxy isWords: expanded).
	interpreterProxy success: (interpreterProxy isBytes: buf).
	interpreterProxy failed ifTrue: [^ nil].

	interpreterProxy success: ((interpreterProxy stSizeOf: expanded) = 80).
	interpreterProxy success: ((interpreterProxy stSizeOf: buf) = 64).
	interpreterProxy failed ifTrue: [^ nil].

	wordPtr := interpreterProxy firstIndexableField: expanded.
	bytePtr := interpreterProxy firstIndexableField: buf.

	src := 0.
	0 to: 15 do: [:i |
		v := ((bytePtr at: src) << 24) +
			((bytePtr at: src + 1) << 16) +
			((bytePtr at: src + 2) << 8) +
			(bytePtr at: src + 3).
		wordPtr at: i put: v.
		src := src + 4].

	16 to: 79 do: [:i |
		v := (((wordPtr at: i - 3) bitXor:
			 (wordPtr at: i - 8)) bitXor:
			 (wordPtr at: i - 14)) bitXor:
			 (wordPtr at: i - 16).
		v := self leftRotate: v by: 1.
		wordPtr at: i put: v].

	interpreterProxy pop: 2.
