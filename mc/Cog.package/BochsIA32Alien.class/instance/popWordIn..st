accessing-abstract
popWordIn: aMemory 
	| sp word |
	word := aMemory unsignedLongAt: (sp := self esp) + 1 bigEndian: false.
	self esp: sp + 4.
	^word