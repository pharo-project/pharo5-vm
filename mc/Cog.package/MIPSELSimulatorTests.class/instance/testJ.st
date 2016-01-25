tests - control
testJ
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler addiuR: V0 R: ZR C: 3).
			stream nextPut: (compiler jA: 16r10).
			stream nextPut: (compiler nop). "Delay slot"
			stream nextPut: (compiler addiuR: V0 R: V0 C: 4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  24020003  addiu v0, zr, 3
00000004  08000004  j 10
00000008  00000000  nop
0000000C  24420004  addiu v0, v0, 4
00000010  03E00008  jr ra
00000014  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 3].