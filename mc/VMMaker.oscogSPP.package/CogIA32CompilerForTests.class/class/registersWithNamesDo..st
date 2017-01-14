test support
registersWithNamesDo: aBinaryBlock
	self registers
		with: #('%eax' '%ecx' '%edx' '%ebx' '%esp' '%ebp' '%esi' '%edi')
		do: aBinaryBlock