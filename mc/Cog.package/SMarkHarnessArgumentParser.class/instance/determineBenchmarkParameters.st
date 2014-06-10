argument parsing
determineBenchmarkParameters
	"Initialize with defaults, will be overwritten in case
	 it is specified."
	iterations := runner class defaultNumberOfIterations.
	processes  := runner class defaultNumberOfProcesses.
	problemSize:= suiteClass defaultProblemSize.
	
	self determineBenchmarkParametersFromArguments.