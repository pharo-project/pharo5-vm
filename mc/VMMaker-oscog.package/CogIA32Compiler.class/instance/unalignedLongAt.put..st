memory access
unalignedLongAt: byteAddress put: aWord
	<cmacro: '(inst,byteAddress,aWord) longAtput(byteAddress,aWord)'>
	^objectMemory unalignedLongAt: byteAddress put: aWord