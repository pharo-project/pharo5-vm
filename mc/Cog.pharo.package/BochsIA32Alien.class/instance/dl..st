accessing
dl: aByte
	self edx: ((self edx bitAnd: -16rFF) + aByte).
	^aByte