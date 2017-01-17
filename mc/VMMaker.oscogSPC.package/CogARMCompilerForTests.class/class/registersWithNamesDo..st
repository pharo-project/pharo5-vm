test support
registersWithNamesDo: aBinaryBlock
	self registers
		with: #('r0' 'r1' 'r2' 'r3' 'r4' 'r5' 'r6' 'r7' 'r8' 'r9' 'sl' 'fp' 'ip' 'sp' 'lr' 'pc')
		do: aBinaryBlock