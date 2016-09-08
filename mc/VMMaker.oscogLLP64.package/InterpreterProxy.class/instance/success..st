other
success: aBoolean
	<returnTypeC: #sqInt>
	aBoolean ifTrue: [^self].
	primFailCode = 0 ifTrue: [self primitiveFailFor: 1]