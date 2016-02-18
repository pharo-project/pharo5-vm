tests - arithmetic
testXor
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler xorR: V0 R: A0 R: A1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00851026  xor v0, a0, a1
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 2r101 with: 2r011 with: 0 with: 0.
			self assert: result equals: 2r110.
			result := simulator call: 0 with: -1 with: 42 with: 0 with: 0.
			self assert: result equals: 42 bitInvert].