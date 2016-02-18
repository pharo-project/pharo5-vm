tests - arithmetic
testLoadLargeLiteral
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler luiR: V0 C: 16r3FFF).
			stream nextPut: (compiler oriR: V0 R: V0 C: 16rFFFF).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  3C023FFF  lui v0, 16383
00000004  3442FFFF  ori v0, v0, 65535
00000008  03E00008  jr ra
0000000C  00000000  nop
'		run: 
			[:simulator | 
			result := simulator call: 0.
			self assert: result equals: 16r3FFFFFFF].