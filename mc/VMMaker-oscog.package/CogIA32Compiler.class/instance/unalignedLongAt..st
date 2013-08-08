memory access
unalignedLongAt: byteAddress
	<cmacro: '(inst,byteAddress) longAt(byteAddress)'>
	^objectMemory unalignedLongAt: byteAddress