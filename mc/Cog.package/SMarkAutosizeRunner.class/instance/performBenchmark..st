benchmarking
performBenchmark: aSelector
	"First determine a useful number of inner loop iterations until the targetTime is reached."
	| execTime i |
	"make sure no timers are recorded for this"
	timers := nil.
	
	i := 1.
	execTime := Time millisecondsToRun: [ suite perform: aSelector. ].
	
	[ execTime > targetTime ] whileFalse: [
		i := i * 2. "Was thinking of doing something fancy here, but just go with this simple staight-forward solution"
		execTime := Time millisecondsToRun: [ 1 to: i do: [:ignored| suite perform: aSelector]].
	].

	innerLoopIterations := i.
	
	"Then start executing the benchmark"
	^ super performBenchmark: aSelector.