tests - arithmetic
testMult
	"Strangely, objdump is unable to disassemble this sequence."	
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler multR: A0 R: A1).
			stream nextPut: (compiler mfloR: V0).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00850018  mult a0, a1
00000004  00001012  mflo v0
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 5 with: 0 with: 0.
			self assert: result equals: 15.
			result := simulator call: 0 with: -3 with: 5 with: 0 with: 0.
			self assert: result equals: -15.
			result := simulator call: 0 with: 3 with: -5 with: 0 with: 0.
			self assert: result equals: -15.
			result := simulator call: 0 with: -3 with: -5 with: 0 with: 0.
			self assert: result equals: 15.
			result := simulator call: 0 with: 5 with: 3 with: 0 with: 0.
			self assert: result equals: 15.
			result := simulator call: 0 with: -5 with: 3 with: 0 with: 0.
			self assert: result equals: -15.
			result := simulator call: 0 with: 5 with: -3 with: 0 with: 0.
			self assert: result equals: -15.
			result := simulator call: 0 with: -5 with: -3 with: 0 with: 0.
			self assert: result equals: 15.
			result := simulator call: 0 with: 16r1000000 with: 16r4567 with: 0 with: 0.
			self assert: result equals: 16r67000000.
			result := simulator call: 0 with: 16r7FFFFFFF with: 16r7FFFFFFF with: 0 with: 0.
			self assert: result equals: 1].	
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler multR: A0 R: A1).
			stream nextPut: (compiler mfhiR: V0).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  00850018  mult a0, a1
00000004  00001010  mfhi v0
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0 with: 3 with: 5 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -3 with: 5 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: 3 with: -5 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: -3 with: -5 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 5 with: 3 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: -5 with: 3 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: 5 with: -3 with: 0 with: 0.
			self assert: result equals: -1.
			result := simulator call: 0 with: -5 with: -3 with: 0 with: 0.
			self assert: result equals: 0.
			result := simulator call: 0 with: 16r1000000 with: 16r4567 with: 0 with: 0.
			self assert: result equals: 16r45.
			result := simulator call: 0 with: 16r7FFFFFFF with: 16r7FFFFFFF with: 0 with: 0.
			self assert: result equals:  16r3FFFFFFF].