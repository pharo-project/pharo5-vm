tests - arithmetic
testOriNegative
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler oriR: V0 R: ZR C: -42).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3402FFD6  ori v0, zr, 65494
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 16r10000 - 42].