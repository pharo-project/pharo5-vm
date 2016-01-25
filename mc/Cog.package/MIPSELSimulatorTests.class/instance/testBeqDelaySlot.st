tests - control
testBeqDelaySlot
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler beqR: A0 R: A1 offset: 8).
			stream nextPut: (compiler addiuR: V0 R: ZR C: 3). "Delay slot"
			stream nextPut: (compiler addiuR: V0 R: V0 C: 4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  10850002  beq a0, a1, +8 ; =C
00000004  24020003  addiu v0, zr, 3
00000008  24420004  addiu v0, v0, 4
0000000C  03E00008  jr ra
00000010  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 0 with: 0 with: 0 with: 0.
			self assert: result equals: 3.
			result := simulator call: 0 with: 1 with: 0 with: 0 with: 0.
			self assert: result equals: 7].