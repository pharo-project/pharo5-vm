profiling
execute: aSuite selector: aBenchmarkSelector
	| runner |
	runner := self new.
	aSuite runner: runner.
	runner 
		suite: aSuite;
		execute: aBenchmarkSelector.
	^ runner