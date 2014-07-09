execution
pushWord: aValue in: aMemory
	| sp |
	sp := (self esp: self esp - 4).
	aMemory longAt: sp + 1 put: aValue bigEndian: false