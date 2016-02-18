execution
pushWord: aValue in: aMemory
	| sp |
	sp := (self rsp: self rsp - 8).
	aMemory long64At: sp + 1 put: aValue