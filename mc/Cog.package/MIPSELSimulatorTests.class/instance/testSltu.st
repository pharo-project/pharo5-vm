tests - arithmetic
testSltu
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler sltuR: V0 R: A0 R: A1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  0085102B  sltu v0, a0, a1
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 4 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: 4 with: 3 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -3 with: 4 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 4 with: -3 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: 5 with: 5 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -5 with: -5 with: 0 with: 0.
			self assert: result equals: 0].