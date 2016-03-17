converting
positive32BitIntegerFor: integerValue
	<var: 'integerValue' type: #'unsigned int'>
	integerValue isInteger ifFalse:[self error:'Not an Integer object'].
	^integerValue > 0
		ifTrue:[integerValue]
		ifFalse:[ (1 bitShift: 32) + integerValue]