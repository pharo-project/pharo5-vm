memory access
unalignedLongAt: byteAddress put: aWord
	<cmacro: '(byteAddress,aWord) longAtput(byteAddress,aWord)'>
	^objectMemory unalignedLongAt: byteAddress put: aWord