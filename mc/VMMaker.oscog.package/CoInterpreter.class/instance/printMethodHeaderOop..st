debug printing
printMethodHeaderOop: anOop
	"Print the CogMethod and its header if this is a CogMethod reference."
	| cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	(self isCogMethodReference: anOop) ifTrue:
		[cogMethod := cogMethodZone methodFor: (self pointerForOop: anOop).
		 cogMethod ~= 0 ifTrue:
			[^self printHex: anOop; space; printOopShort: cogMethod methodHeader]].
	^self printOopShort: anOop