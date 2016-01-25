tests - arithmetic
testAnd
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler andR: V0 R: A0 R: A1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00851024  and v0, a0, a1
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 2r1101 with: 2r1011 with: 0 with: 0.
			self assert: result equals: 2r1001.
			result := simulator call: 0 with: -1 with: 42 with: 0 with: 0.
			self assert: result equals: 42].