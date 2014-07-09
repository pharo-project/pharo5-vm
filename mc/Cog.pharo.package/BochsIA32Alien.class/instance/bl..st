accessing
bl: aByte
	self ebx: ((self ebx bitAnd: -16rFF) + aByte).
	^aByte