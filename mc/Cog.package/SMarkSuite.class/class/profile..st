profiling
profile: aSelector
	^ self profileRunner 
		execute: self new selector: aSelector.