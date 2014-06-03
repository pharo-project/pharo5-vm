benchmarking
run
	"Executes all the benchmarks in the suite, 
	 coordinating with the runner when necessary"
	
	| potentialBenchmarkSelectors |
	selectedBenchmarks
		ifNotNil: [ potentialBenchmarkSelectors := selectedBenchmarks ]
		ifNil:    [ potentialBenchmarkSelectors := self class allSelectors ].				
	
	potentialBenchmarkSelectors
		do: [ :selector |
			(self shouldRunSelector: selector)
				ifTrue: [
					runner performBenchmark: selector ]
		].
	