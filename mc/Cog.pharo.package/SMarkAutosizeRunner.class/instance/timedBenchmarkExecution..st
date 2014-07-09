benchmarking
timedBenchmarkExecution: aSelector
	"Will do a timed execution of the benchmark and return the result timer"
	| timer |
	timers := Dictionary new.

	timer := self createTimer: 'total'.
	
	timer start.
	1 to: innerLoopIterations do: [:ignored|
		suite perform: aSelector.
	].
	timer stop.
	
	self recordResults: timer for: aSelector.
	
	^ timer