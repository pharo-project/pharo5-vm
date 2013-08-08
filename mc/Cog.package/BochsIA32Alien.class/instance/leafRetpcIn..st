accessing-abstract
leafRetpcIn: aMemory
	^aMemory unsignedLongAt: self esp + 1 bigEndian: false