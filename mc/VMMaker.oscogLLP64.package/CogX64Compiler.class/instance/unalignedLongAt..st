memory access
unalignedLongAt: byteAddress
	<cmacro: '(byteAddress) longAt(byteAddress)'>
	^objectMemory unalignedLongAt: byteAddress