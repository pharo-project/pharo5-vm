helper
instructRunner
	suite := suiteClass new.
	specificBenchmark ifNotNil: [
		suite runOnly: specificBenchmark.
	].
	
	runner suite: suite.
 	runner iterations: iterations.
	runner processes: processes.
	runner problemSize: problemSize.