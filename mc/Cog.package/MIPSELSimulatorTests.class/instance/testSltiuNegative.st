tests - arithmetic
testSltiuNegative
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler sltiuR: V0 R: A0 C: -3).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  2C82FFFD  sltiu v0, a0, -3
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 2 with: 0 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: 3 with: 0 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: 4 with: 0 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: -2 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -3 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -4 with: 0 with: 0 with: 0.
			self assert: result equals: 1].