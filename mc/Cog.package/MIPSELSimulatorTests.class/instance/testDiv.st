tests - arithmetic
testDiv
	"Strangely, objdump is unable to disassemble this sequence."	
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler divR: A0 R: A1).
			stream nextPut: (compiler mfloR: V0).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  0085001A  div a0, a1
00000004  00001012  mflo v0
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 7 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -3 with: 7 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 3 with: -7 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -3 with: -7 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 7 with: 3 with: 0 with: 0.
			self assert: result equals: 2.
			result := simulator call: 0 with: -7 with: 3 with: 0 with: 0.
			self assert: result equals: -2.
			result := simulator call: 0 with: 7 with: -3 with: 0 with: 0.
			self assert: result equals: -2.
			result := simulator call: 0 with: -7 with: -3 with: 0 with: 0.
			self assert: result equals: 2.
			result := simulator call: 0 with: 42 with: 0 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -16r80000000 with: -1 with: 0 with: 0.
			self assert: result equals: -16r80000000].	
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler divR: A0 R: A1).
			stream nextPut: (compiler mfhiR: V0).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  0085001A  div a0, a1
00000004  00001010  mfhi v0
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 7 with: 0 with: 0.
			self assert: result equals: 3.
			result := simulator call: 0 with: -3 with: 7 with: 0 with: 0.
			self assert: result equals: -3.
			result := simulator call: 0 with: 3 with: -7 with: 0 with: 0.
			self assert: result equals: 3.
			result := simulator call: 0 with: -3 with: -7 with: 0 with: 0.
			self assert: result equals: -3.
			result := simulator call: 0 with: 7 with: 3 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: -7 with: 3 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: 7 with: -3 with: 0 with: 0.
			self assert: result equals: 1.
			result := simulator call: 0 with: -7 with: -3 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: 42 with: 0 with: 0 with: 0.
			self assert: result equals: 42.
			result := simulator call: 0 with: -16r80000000 with: -1 with: 0 with: 0.
			self assert: result equals: 0].