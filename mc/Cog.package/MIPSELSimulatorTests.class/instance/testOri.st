tests - arithmetic
testOri
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler oriR: V0 R: ZR C: 16rFFFF).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3402FFFF  ori v0, zr, 65535
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 16rFFFF].