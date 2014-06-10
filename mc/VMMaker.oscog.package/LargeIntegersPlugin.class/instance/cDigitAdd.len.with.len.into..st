C core
cDigitAdd: pByteShort len: shortLen with: pByteLong len: longLen into: pByteRes 
	"pByteRes len = longLen; returns over.."
	| accum limit |
	<returnTypeC: 'unsigned char'>
	<var: #pByteShort type: 'unsigned char * '>
	<var: #pByteLong type: 'unsigned char * '>
	<var: #pByteRes type: 'unsigned char * '>
	accum := 0.
	limit := shortLen - 1.
	0 to: limit do: 
		[:i | 
		accum := (accum bitShift: -8)
					+ (pByteShort at: i) + (pByteLong at: i).
		pByteRes at: i put: (accum bitAnd: 255)].
	limit := longLen - 1.
	shortLen to: limit do: 
		[:i | 
		accum := (accum bitShift: -8)
					+ (pByteLong at: i).
		pByteRes at: i put: (accum bitAnd: 255)].
	^ accum bitShift: -8