benchmarking
timedBenchmarkExecution: aSelector
	"Will do a timed execution of the benchmark and return the result timer"
	| timer result |
	timers := Dictionary new.

	timer := self createTimer: 'total'.
	
	timer start.
	result := suite perform: aSelector.
	timer stop.
	suite processResult: result withTimer: timer.
	
	self recordResults: timer for: aSelector.
	
	^ timer