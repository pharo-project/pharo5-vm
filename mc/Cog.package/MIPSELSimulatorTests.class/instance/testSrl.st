tests - arithmetic
testSrl
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler srlR: V0 R: A0 C: 2).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00041082  srl v0, a0, 2
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 42 with: 0 with: 0 with: 0.
			self assert: result equals: 42 >> 2.
			result := simulator call: 0 with: -42 with: 0 with: 0 with: 0.
			self assert: result equals: (16r100000000 - 42) >> 2].