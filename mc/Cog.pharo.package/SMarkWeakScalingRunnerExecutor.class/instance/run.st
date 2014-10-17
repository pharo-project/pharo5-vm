benchmarking
run
	1 to: numInnerIterations do: [:i |
		suite perform: benchmarkSelector.].
	
	runner executorCompleted.