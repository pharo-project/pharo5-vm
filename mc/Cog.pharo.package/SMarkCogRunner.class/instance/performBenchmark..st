initialization
performBenchmark: aSelector
	"Based on an email by Eliot from May 16th, 2011.
	 The first time a method is executed it will get into the inline cache.
	 The second time, it is found in the inline cache, which triggers the JIT compiler to produce code.
	 Thus, the third time it should be executed in the steady state."
	warmingUp := true.
		suite runBenchmark: aSelector.
		Smalltalk garbageCollect.
		suite runBenchmark: aSelector.
		Smalltalk garbageCollect.
	warmingUp := false.
	
	^ super performBenchmark: aSelector.