converting
positive64BitIntegerFor: integerValue
	<returnTypeC: #sqInt> "...because answering the 64-bit argument causes the type inferencer to say this answers 64-bits."
	<var: 'integerValue' type: #sqLong>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 64) + integerValue]