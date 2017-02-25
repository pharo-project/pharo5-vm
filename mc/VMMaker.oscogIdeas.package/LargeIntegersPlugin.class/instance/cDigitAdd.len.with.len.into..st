C core
cDigitAdd: pWordShort len: shortLen with: pWordLong len: longLen into: pWordRes 
	"pWordRes len = longLen; returns over.."
	| accum |
	<returnTypeC: #'unsigned int'>
	<var: #pWordShort type: #'unsigned int *'>
	<var: #pWordLong type: #'unsigned int *'>
	<var: #pWordRes type: #'unsigned int *'>
	<var: #accum type: #'unsigned long long'>
	accum := 0.
	0 to: shortLen - 1 do: 
		[:i | 
		accum := (accum >> 32)
					+ (self cDigitOf: pWordShort at: i)
					+ (self cDigitOf: pWordLong at: i).
		self cDigitOf: pWordRes at: i put: (accum bitAnd: 16rFFFFFFFF)].
	shortLen to: longLen - 1 do: 
		[:i | 
		accum := (accum >> 32)
					+ (self cDigitOf: pWordLong at: i).
		self cDigitOf: pWordRes at: i put: (accum bitAnd: 16rFFFFFFFF)].
	^ accum >> 32