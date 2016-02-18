accessing-abstract
retpcIn: aMemory
	"The return address is on the stack, having been pushed by either
	 simulateCallOf:nextpc:memory: or simulateJumpCallOf:memory:"
	^aMemory unsignedLongAt: self fp + 5 bigEndian: false