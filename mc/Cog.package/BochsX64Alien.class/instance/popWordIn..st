execution
popWordIn: aMemory 
	| sp word |
	word := aMemory long64At: (sp := self rsp) + 1.
	self rsp: sp + 8.
	^word