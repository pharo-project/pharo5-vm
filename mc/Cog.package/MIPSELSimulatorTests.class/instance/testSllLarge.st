tests - arithmetic
testSllLarge
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler sllR: V0 R: A0 C: 31).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  000417C0  sll v0, a0, 31
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 0 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 42 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -42 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 1 with: 0 with: 0 with: 0.
			self assert: result equals: -16r80000000.
			result := simulator call: 0 with: -1 with: 0 with: 0 with: 0.
			self assert: result equals: -16r80000000].