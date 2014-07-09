accessing
register: int0to15
"return the value of register"
	self assert:[int0to15 between: 0 and:15].
	^self unsignedLongAt: 13 + (4 * int0to15)