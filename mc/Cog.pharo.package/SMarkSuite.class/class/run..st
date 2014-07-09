benchmarking
run: nIterations
	"Execute the suite a given number of iterations."
	
	^ self defaultRunner execute: self new with: nIterations.