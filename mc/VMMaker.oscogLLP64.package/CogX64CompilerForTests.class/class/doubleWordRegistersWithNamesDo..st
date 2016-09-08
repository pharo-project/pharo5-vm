test support
doubleWordRegistersWithNamesDo: aBinaryBlock
	self registers
		with: #('%eax' '%ecx' '%edx' '%ebx' '%esp' '%ebp' '%esi' '%edi' '%r8d' '%r9d' '%r10d' '%r11d' '%r12d' '%r13d' '%r14d' '%r15d')
		do: aBinaryBlock