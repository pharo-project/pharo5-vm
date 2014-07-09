initialization
initialize
	super initialize.
	numIterations := self class defaultNumberOfIterations.
	numProcesses  := self class defaultNumberOfProcesses.
	results := Dictionary new.