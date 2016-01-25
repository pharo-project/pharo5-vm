tests - arithmetic
testXori
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler xoriR: V0 R: A0 C: 16rABCD).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3882ABCD  xori v0, a0, 43981
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 0 with: 0 with: 0 with: 0.
			self assert: result equals: 16rABCD.
			result := simulator call: 0 with: -1 with: 0 with: 0 with: 0.
			self assert: result equals: -16rABCE].