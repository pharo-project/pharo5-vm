converting
floatObjectOf: aFloat
	<var: #aFloat type: 'double '>
	aFloat class == Float ifFalse:[self error:'Not a float object'].
	^aFloat