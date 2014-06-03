simulation only
traceSimStack
	<cmacro: '() 0'>
	(compilationTrace anyMask: 1) ifTrue:
		[self printSimStack]