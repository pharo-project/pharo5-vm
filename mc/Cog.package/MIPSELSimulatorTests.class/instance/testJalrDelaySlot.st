tests - control
testJalrDelaySlot
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler addiuR: T0 R: RA C: 0).
			stream nextPut: (compiler addiuR: T9 R: ZR C: 16r20).
			stream nextPut: (compiler jalR: T9).
			stream nextPut: (compiler addiuR: V0 R: ZR C: 11). "Delay slot"
			stream nextPut: (compiler addiuR: V0 R: V0 C: 3).
			stream nextPut: (compiler jR: T0).
			stream nextPut: (compiler nop). "Delay slot"
			stream nextPut: (compiler stop).
			stream nextPut: (compiler addiuR: V0 R: V0 C: 4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  27E80000  addiu t0, ra, 0
00000004  24190020  addiu t9, zr, 32
00000008  0320F809  jalr t9
0000000C  2402000B  addiu v0, zr, 11
00000010  24420003  addiu v0, v0, 3
00000014  01000008  jr t0
00000018  00000000  nop
0000001C  0000000D  break
00000020  24420004  addiu v0, v0, 4
00000024  03E00008  jr ra
00000028  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 18].