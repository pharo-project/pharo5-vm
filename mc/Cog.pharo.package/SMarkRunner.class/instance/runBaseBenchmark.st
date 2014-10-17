benchmarking
runBaseBenchmark
	"In certain sitatuations it is one wants a baseline that is incooprated in all 
	 benchmark results to be substracted from the final values.
	
	#baseBenchmark can be used to charaterize such a baseline"
	
	(suite respondsTo: #baseBenchmark) 
		ifFalse: [ ^ nil ].
	
	^ self performBenchmark: #baseBenchmark.