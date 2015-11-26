instructions - memory
prefetch: instruction
	self assert: (instruction rt = HintLoad or: [instruction rt = HintStore]).