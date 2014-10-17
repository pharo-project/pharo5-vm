accessing-abstract
retpcIn: aMemory
"the return address is on the stack, apparently"
	^aMemory unsignedLongAt: self fp + 5 bigEndian: false