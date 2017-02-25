debug printing
flush
	<cmacro: '() fflush(stdout)'>
	traceOn ifTrue: [transcript flush]