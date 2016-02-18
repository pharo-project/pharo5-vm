tests - arithmetic
testAndi
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler andiR: V0 R: A0 C: 16rFF).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  308200FF  andi v0, a0, 255
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 16r12345678 with: 0 with: 0 with: 0.
			self assert: result equals: 16r78.
			result := simulator call: 0 with: -1 with: 0 with: 0 with: 0.
			self assert: result equals: 16rFF].