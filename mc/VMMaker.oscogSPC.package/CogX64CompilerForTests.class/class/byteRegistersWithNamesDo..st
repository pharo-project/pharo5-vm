test support
byteRegistersWithNamesDo: aBinaryBlock
	self registers
		with: #('%al' '%cl' '%dl' '%bl' '%spl' '%bpl' '%sil' '%dil' '%r8b' '%r9b' '%r10b' '%r11b' '%r12b' '%r13b' '%r14b' '%r15b')
		do: aBinaryBlock