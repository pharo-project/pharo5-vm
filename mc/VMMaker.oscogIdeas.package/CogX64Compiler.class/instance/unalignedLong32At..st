memory access
unalignedLong32At: byteAddress
	<cmacro: '(inst,byteAddress) long32At(byteAddress)'>
	^ ((objectMemory byteAt: byteAddress + 3) << 24)
	+ ((objectMemory byteAt: byteAddress + 2) << 16)
	+ ((objectMemory byteAt: byteAddress + 1) << 8)
	+  (objectMemory byteAt: byteAddress)