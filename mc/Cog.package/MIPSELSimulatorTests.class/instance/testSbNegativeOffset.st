tests - memory
testSbNegativeOffset
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler sbR: A1 base: A0 offset: -4).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  A085FFFC  sb a1, -4(a0)
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			simulator call: 0 with: 16rE8 with: 42 with: 0 with: 0.
			simulator call: 0 with: 16rE9 with: 43 with: 0 with: 0.
			simulator call: 0 with: 16rEA with: 44 with: 0 with: 0.
			simulator call: 0 with: 16rEB with: 45 with: 0 with: 0.
			simulator call: 0 with: 16rF8 with: -42 with: 0 with: 0.
			simulator call: 0 with: 16rF9 with: -43 with: 0 with: 0.
			simulator call: 0 with: 16rFA with: -44 with: 0 with: 0.
			simulator call: 0 with: 16rFB with: -45 with: 0 with: 0.
			self assert: (simulator memory at: 16rE4 + 1) equals: 42.
			self assert: (simulator memory at: 16rE5 + 1) equals: 43.
			self assert: (simulator memory at: 16rE6 + 1) equals: 44.
			self assert: (simulator memory at: 16rE7 + 1) equals: 45.
			self assert: (simulator memory at: 16rF4 + 1) equals: 16r100 - 42.
			self assert: (simulator memory at: 16rF5 + 1) equals: 16r100 - 43.
			self assert: (simulator memory at: 16rF6 + 1) equals: 16r100 - 44.
			self assert: (simulator memory at: 16rF7 + 1) equals: 16r100 - 45].