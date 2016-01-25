tests - control
testJalDelaySlot
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler addiuR: T0 R: RA C: 0).
			stream nextPut: (compiler jalA: 16r1C).
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
00000004  0C000007  jal 1C
00000008  2402000B  addiu v0, zr, 11
0000000C  24420003  addiu v0, v0, 3
00000010  01000008  jr t0
00000014  00000000  nop
00000018  0000000D  break
0000001C  24420004  addiu v0, v0, 4
00000020  03E00008  jr ra
00000024  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 18].