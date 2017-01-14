converting
floatObjectOf: aFloat
	<returnTypeC: #sqInt> "...because answering the float argument causes the type inferencer to say this answers a float."
	<var: #aFloat type: 'double '>
	aFloat isFloat ifFalse:[self error:'Not a float object'].
	^aFloat