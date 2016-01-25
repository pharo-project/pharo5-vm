tests - arithmetic
testAndiNegative
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler andiR: V0 R: A0 C: -1). "Immediate is zero-extended, so same as 16rFFFF"
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3082FFFF  andi v0, a0, 65535
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 16r12345678 with: 0 with: 0 with: 0.
			self assert: result equals: 16r5678.
			result := simulator call: 0 with: -1 with: 0 with: 0 with: 0.
			self assert: result equals: 16rFFFF].