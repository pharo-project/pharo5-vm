benchmarking
runBaseBenchmark
	"baseBenchmark is not supported with autosizing. I do not see how that can be made possible since all different benchmarks will have different number of iterations, and the only way how a consistent baseline could be found would be to normalize the results, but well, incooprorating the baseline measurement with the statistical evaluation is harder than just substracting a one time value..., I am not going to do that here for the moment. Stefan 2011-03-20"
	
	(suite respondsTo: #baseBenchmark) 
		ifFalse: [ ^ nil ].
	
	"I decided to go here with a silent solution to avoid thinking about logging frameworks and Transcript to console convertion..."
	self recordResults: (self class defaultTimer new: 'total') for: #baseBenchmark  