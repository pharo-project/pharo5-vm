accessing
roundUpAddress: address
	<returnTypeC: #'void *'>
	<var: #address type: #'void *'>
	^self cCoerce: ((self cCoerce: address to: 'unsigned long') + 7 bitAnd: -8) to: #'void *'