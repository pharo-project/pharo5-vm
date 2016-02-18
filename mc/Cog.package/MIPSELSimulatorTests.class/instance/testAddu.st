tests - arithmetic
testAddu
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler adduR: V0 R: A0 R: A1).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00851021  addu v0, a0, a1
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 4 with: 0 with: 0.
			self assert: result equals: 7.
			result := simulator call: 0 with: 3 with: -4 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: -3 with: 4 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: 16r7FFFFFFF with: 1 with: 0 with: 0.
			self assert: result equals: (-1 << 31).
			result := simulator call: 0 with: (-1 << 31) with: -1 with: 0 with: 0.
			self assert: result equals: (1 << 31) - 1].