tests - arithmetic
testAddiuOverflow
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler luiR: T0 C: 16r7FFF).
			stream nextPut: (compiler oriR: T0 R: T0 C: 16rFFFF).
			stream nextPut: (compiler addiuR: V0 R: T0 C: 1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3C087FFF  lui t0, 32767
00000004  3508FFFF  ori t0, t0, 65535
00000008  25020001  addiu v0, t0, 1
0000000C  03E00008  jr ra
00000010  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: -1 << 31].