simulation only
traceDescriptor: descriptor
	<cmacro: '(ign) 0'>
	(compilationTrace anyMask: 2) ifTrue:
		[coInterpreter transcript cr; print: bytecodePC; space; nextPutAll: descriptor generator.
		 deadCode ifTrue: [coInterpreter transcript nextPutAll: ' => deadCode'].
		 coInterpreter flush]