processor api
popWordIn: aMemory 
	| sp word |
	word := aMemory unsignedLongAt: (sp := self sp) + 1 bigEndian: false.
	self sp: sp + 4.
	^word