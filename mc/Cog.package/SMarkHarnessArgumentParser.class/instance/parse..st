parsing
parse: argumentsArray
	arguments := argumentsArray.
	numParams := arguments size.
	
	i := 2.
	current := arguments at: i.
	currentObj := (Smalltalk classNamed: current) ifNotNilDo: [:cls | cls new].
		
	self determineRunner.
	self determineReporter.
	
	self determineSuiteOrBenchmark.
	
	self determineBenchmarkParameters.
	
	self instructRunner.
	
	^ {runner. reporter}