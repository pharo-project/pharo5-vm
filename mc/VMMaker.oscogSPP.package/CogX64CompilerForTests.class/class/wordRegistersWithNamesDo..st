test support
wordRegistersWithNamesDo: aBinaryBlock
	self registers
		with: #('%ax' '%cx' '%dx' '%bx' '%sp' '%bp' '%si' '%di' '%r8w' '%r9w' '%r10w' '%r11w' '%r12w' '%r13w' '%r14w' '%r15w')
		do: aBinaryBlock