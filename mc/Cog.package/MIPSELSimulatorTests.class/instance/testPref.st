tests - memory
testPref
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler prefR: A0 offset: 0 hint: HintLoad).
			stream nextPut: (compiler jR: RA).
			stream nextPut: (compiler nop). "Delay slot"]
		disassembly:
'00000000  CC800000  pref load, 0(a0)
00000004  03E00008  jr ra
00000008  00000000  nop
'		run: 
			[:simulator | 
			"No exception even though the address is not part of memory."
			simulator call: 0 with: -42 with: 0 with: 0 with: 0].