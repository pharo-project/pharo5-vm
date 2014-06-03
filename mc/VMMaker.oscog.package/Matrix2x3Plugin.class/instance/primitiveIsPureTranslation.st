primitives
primitiveIsPureTranslation
	| matrix |
	<export: true>
	<inline: false>
	<var: #matrix type: 'float *'>
	matrix := self loadArgumentMatrix: (interpreterProxy stackObjectValue: 0).
	interpreterProxy failed ifTrue:[^nil].
	interpreterProxy pop: 1.
	interpreterProxy pushBool:(
		((matrix at: 0) = (self cCoerce: 1.0 to: 'float')) &
		((matrix at: 1) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 3) = (self cCoerce: 0.0 to: 'float')) &
		((matrix at: 4) = (self cCoerce: 1.0 to: 'float'))).