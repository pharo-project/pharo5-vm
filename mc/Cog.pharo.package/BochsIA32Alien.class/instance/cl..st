accessing
cl: aByte
	self ecx: ((self ecx bitAnd: -16rFF) + aByte).
	^aByte