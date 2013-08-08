other
success: aBoolean
	aBoolean ifTrue: [^self].
	primFailCode = 0 ifTrue: [self primitiveFailFor: 1]