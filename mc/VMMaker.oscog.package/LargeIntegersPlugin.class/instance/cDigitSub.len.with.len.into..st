C core
cDigitSub: pByteSmall len: smallLen with: pByteLarge len: largeLen into: pByteRes
	| z |
	<var: #pByteSmall type: #'unsigned char *'>
	<var: #pByteLarge type: #'unsigned char *'>
	<var: #pByteRes type: #'unsigned char *'>

	z := 0. "Loop invariant is -1<=z<=1"
	0 to: smallLen - 1 do: 
		[:i | 
		z := z + (pByteLarge at: i) - (pByteSmall at: i).
		pByteRes at: i put: (self cCode: [z] inSmalltalk: [z bitAnd: 255]).
		z := z signedBitShift: -8].
	smallLen to: largeLen - 1 do: 
		[:i | 
		z := z + (pByteLarge at: i) .
		pByteRes at: i put: (self cCode: [z] inSmalltalk: [z bitAnd: 255]).
		z := z signedBitShift: -8].
