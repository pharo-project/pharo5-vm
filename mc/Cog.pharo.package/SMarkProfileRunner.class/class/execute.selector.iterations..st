profiling
execute: aSuite selector: aBenchmarkSelector iterations: nIterations
	| runner |
	runner := self new.
	aSuite runner: runner.
	runner 
		suite: aSuite;
		iterations: nIterations;
		execute: aBenchmarkSelector.
	^ runner