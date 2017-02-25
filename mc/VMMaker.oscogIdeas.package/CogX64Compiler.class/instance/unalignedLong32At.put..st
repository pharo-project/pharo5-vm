memory access
unalignedLong32At: byteAddress put: aWord
	<cmacro: '(inst,byteAddress,aWord) long32Atput(byteAddress,aWord)'>
	objectMemory
		byteAt: byteAddress + 0 put:  (aWord bitAnd: 16rFF);
		byteAt: byteAddress + 1 put: ((aWord >> 8) bitAnd: 16rFF);
		byteAt: byteAddress + 2 put: ((aWord >> 16) bitAnd: 16rFF);
		byteAt: byteAddress + 3 put: ((aWord >> 24) bitAnd: 16rFF).
	^aWord