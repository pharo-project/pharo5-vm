benchmarking
execute: aBenchmarkOrSuite using: aRunnerClass andReport: withAReporterClass
	| parsedBenchmarkOrSuite runner reporter |
	
	parsedBenchmarkOrSuite := self parseBenchmarkOrSuite: aBenchmarkOrSuite.
	
	runner := aRunnerClass new.
	reporter := withAReporterClass new.
	self instructRunner: runner with: parsedBenchmarkOrSuite.
	self execute: runner andReport: reporter.   