benchmarking
execute: aSuite with: nIterations
	| runner |
	runner := self new.
	aSuite runner: runner.
	runner suite: aSuite.
	runner iterations: nIterations.  
	runner execute.
	^ runner