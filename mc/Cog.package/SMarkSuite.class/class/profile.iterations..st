profiling
profile: aSelector iterations: nIterations
	^ self profileRunner 
		execute: self new selector: aSelector iterations: nIterations.