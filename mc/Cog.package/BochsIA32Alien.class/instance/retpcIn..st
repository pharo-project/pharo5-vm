accessing-abstract
retpcIn: aMemory
	^aMemory unsignedLongAt: self ebp + 5 bigEndian: false