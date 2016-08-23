C core
cDigitSub: pWordSmall
		len: smallLen
		with: pWordLarge
		len: largeLen
		into: pWordRes
	| z |
	<var: #pWordSmall type: #'unsigned int *'>
	<var: #pWordLarge type: #'unsigned int *'>
	<var: #pWordRes type: #'unsigned int *'>
	<var: #z type: #'unsigned long long'>

	z := 0.
	0 to: smallLen - 1 do: 
		[:i | 
		z := z + (self cDigitOf: pWordLarge at: i) - (self cDigitOf: pWordSmall at: i).
		self cDigitOf: pWordRes at: i put: (z bitAnd: 16rFFFFFFFF).
		z := 0 - (z >> 63)].
	smallLen to: largeLen - 1 do: 
		[:i | 
		z := z + (self cDigitOf: pWordLarge at: i) .
		self cDigitOf: pWordRes at: i put: (z bitAnd: 16rFFFFFFFF).
		z := 0 - (z >> 63)].
	^0