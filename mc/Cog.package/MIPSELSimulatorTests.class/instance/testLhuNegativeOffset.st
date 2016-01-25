tests - memory
testLhuNegativeOffset
	| result |
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler lhuR: V0 base: A0 offset: -4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  9482FFFC  lhu v0, -4(a0)
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
			result := simulator call: 0 with: 16rE8 with: 0 with: 0 with: 0.
			self assert: result equals: 16r2B2A.
			self should: [simulator call: 0 with: 16rE9 with: 0 with: 0 with: 0] raise: Error.
			result := simulator call: 0 with: 16rEA with: 0 with: 0 with: 0.
			self assert: result equals: 16r2D2C.
			self should: [simulator call: 0 with: 16rEB with: 0 with: 0 with: 0] raise: Error.
			result := simulator call: 0 with: 16rF8 with: 0 with: 0 with: 0.
			self assert: result equals: 16rD5D6.
			self should: [simulator call: 0 with: 16rF9 with: 0 with: 0 with: 0] raise: Error.
			result := simulator call: 0 with: 16rFA with: 0 with: 0 with: 0.
			self assert: result equals: 16rD3D4.
			self should: [simulator call: 0 with: 16rFB with: 0 with: 0 with: 0] raise: Error].