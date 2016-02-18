tests - control
testBgezDelaySlot
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler bgezR: A0 offset: 8).
			stream nextPut: (compiler addiuR: V0 R: ZR C: 4). "Delay slot"
			stream nextPut: (compiler addiuR: V0 R: ZR C: 3).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  04810002  bgez a0, +8 ; =C
00000004  24020004  addiu v0, zr, 4
00000008  24020003  addiu v0, zr, 3
0000000C  03E00008  jr ra
00000010  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: -1 with: 0 with: 0 with: 0.
			self assert: result equals: 3.
			result := simulator call: 0 with: 0 with: 0 with: 0 with: 0.
			self assert: result equals: 4.
			result := simulator call: 0 with: 1 with: 0 with: 0 with: 0.
			self assert: result equals: 4].