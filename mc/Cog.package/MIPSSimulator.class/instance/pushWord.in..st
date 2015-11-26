processor api
pushWord: aValue in: aMemory
	aMemory longAt: (self sp: self sp - 4) + 1 put: aValue bigEndian: false