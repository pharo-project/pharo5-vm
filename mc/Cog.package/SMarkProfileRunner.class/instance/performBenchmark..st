benchmarks
performBenchmark: aSelector
	currentBenchmark := aSelector.
	
	1 to: numIterations do: [:i|
		suite runBenchmark: aSelector ].	
	
	currentBenchmark := nil.