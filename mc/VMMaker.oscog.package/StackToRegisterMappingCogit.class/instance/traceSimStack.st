simulation only
traceSimStack
	<cmacro: '() 0'>
	(compilationTrace anyMask: 4) ifTrue:
		[self printOptStatus; printSimSelf; printSimStack]