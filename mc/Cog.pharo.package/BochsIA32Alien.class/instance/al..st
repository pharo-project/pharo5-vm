accessing
al: aByte
	self eax: ((self eax bitAnd: -16rFF) + aByte).
	^aByte