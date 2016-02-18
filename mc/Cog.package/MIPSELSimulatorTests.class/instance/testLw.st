tests - memory
testLw
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler lwR: V0 base: A0 offset: 4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  8C820004  lw v0, 4(a0)
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			simulator memory at: 16rE4 + 1 put: 42.
			simulator memory at: 16rE5 + 1 put: 43.
			simulator memory at: 16rE6 + 1 put: 44.
			simulator memory at: 16rE7 + 1 put: 45.
			simulator memory at: 16rF4 + 1 put: 16r100 - 42.
			simulator memory at: 16rF5 + 1 put: 16r100 - 43.
			simulator memory at: 16rF6 + 1 put: 16r100 - 44.
			simulator memory at: 16rF7 + 1 put: 16r100 - 45.
			result := simulator call: 0 with: 16rE0 with: 0 with: 0 with: 0.
			self assert: result equals: 16r2D2C2B2A.
			self should: [simulator call: 0 with: 16rE1 with: 0 with: 0 with: 0] raise: Error.
			self should: [simulator call: 0 with: 16rE2 with: 0 with: 0 with: 0] raise: Error.
			self should: [simulator call: 0 with: 16rE3 with: 0 with: 0 with: 0] raise: Error.
			result := simulator call: 0 with: 16rF0 with: 0 with: 0 with: 0.
			self assert: result equals: -16r2C2B2A2A.
			self should: [simulator call: 0 with: 16rF1 with: 0 with: 0 with: 0] raise: Error.
			self should: [simulator call: 0 with: 16rF2 with: 0 with: 0 with: 0] raise: Error.
			self should: [simulator call: 0 with: 16rF3 with: 0 with: 0 with: 0] raise: Error].