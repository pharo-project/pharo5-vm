tests - arithmetic
testAddiuUnderflow
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler luiR: T0 C: 16r8000).
			stream nextPut: (compiler addiuR: V0 R: T0 C: -1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3C088000  lui t0, -32768
00000004  2502FFFF  addiu v0, t0, -1
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: (1 << 31) - 1].