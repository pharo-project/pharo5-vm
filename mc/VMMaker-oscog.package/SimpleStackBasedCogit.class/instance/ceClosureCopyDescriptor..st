trampolines
ceClosureCopyDescriptor: descriptor "<Integer>" 
	^coInterpreter
		createClosureNumArgs: (descriptor bitAnd: 16r3F)
		numCopied: ((descriptor >> 6) bitAnd: 16r3F)
		startpc: descriptor >> 12