tests - control
testBreak
	self 
		testGenerateInto: 
			[:stream :compiler | 
			stream nextPut: (compiler break: 0)]
		disassembly:
'00000000  0000000D  break
'		run: 
			[:simulator | 
			self should: [simulator call: 0 with: 0 with: 0 with: 0 with: 0] raise: Error].