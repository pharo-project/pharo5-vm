benchmarking
performBenchmark: aSelector
	currentBenchmark := aSelector.
	
	1 to: numIterations do: [:i|
		"self timedBenchmarkExecution: aSelector."
		suite runBenchmark: aSelector.  
	].	
	
	currentBenchmark := nil.
	
	^ results at: (suite benchmarkNameForSelector: aSelector)