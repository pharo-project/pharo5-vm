simulation only
traceSpill: simStackEntry
	<cmacro: '(ign) 0'>
	(compilationTrace anyMask: 2) ifTrue:
		[coInterpreter transcript cr; print: bytecodePC; space; print: simStackEntry; flush]