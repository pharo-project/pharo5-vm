accessing
roundUpAddress: address
	<returnTypeC: #'void *'>
	<var: #address type: #'void *'>
	^self cCoerce: ((self cCoerce: address to: #'usqIntptr_t') + 7 bitAnd: -8) to: #'void *'