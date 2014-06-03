C core
cDigitSub: pByteSmall
		len: smallLen
		with: pByteLarge
		len: largeLen
		into: pByteRes
	| z limit |
	<var: #pByteSmall type: 'unsigned char * '>
	<var: #pByteLarge type: 'unsigned char * '>
	<var: #pByteRes type: 'unsigned char * '>

	z := 0.
	"Loop invariant is -1<=z<=1"
	limit := smallLen - 1.
	0 to: limit do: 
		[:i | 
		z := z + (pByteLarge at: i) - (pByteSmall at: i).
		pByteRes at: i put: z - (z // 256 * 256).
		"sign-tolerant form of (z bitAnd: 255)"
		z := z // 256].
	limit := largeLen - 1.
	smallLen to: limit do: 
		[:i | 
		z := z + (pByteLarge at: i) .
		pByteRes at: i put: z - (z // 256 * 256).
		"sign-tolerant form of (z bitAnd: 255)"
		z := z // 256].
