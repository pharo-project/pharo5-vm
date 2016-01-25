tests - control
testJr
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler addiuR: V0 R: ZR C: 3).
			stream nextPut: (compiler addiuR: T9 R: ZR C: 16r14).
			stream nextPut: (compiler jR: T9).
			stream nextPut: (compiler nop). "Delay slot"
			stream nextPut: (compiler addiuR: V0 R: V0 C: 4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  24020003  addiu v0, zr, 3
00000004  24190014  addiu t9, zr, 20
00000008  03200008  jr t9
0000000C  00000000  nop
00000010  24420004  addiu v0, v0, 4
00000014  03E00008  jr ra
00000018  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 3].