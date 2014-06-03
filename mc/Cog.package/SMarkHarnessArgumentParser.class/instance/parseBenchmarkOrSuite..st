argument parsing
parseBenchmarkOrSuite: aBenchmarkOrSuite
	"Identify the benchmark suite or suite and benchmark method
	 that should be executed. The string should be of the format 'Class>>benchName' or 'Class.benchName' for shell/bash compatibility.
	 Accepts a string, class, or array.
	 Returns, a class, or an array of a class and a symbol."
	| parsed |
	(aBenchmarkOrSuite isKindOf: Class)
		ifTrue: [
			suiteClass := aBenchmarkOrSuite.
			^ suiteClass
		].
	  
	(aBenchmarkOrSuite isKindOf: Array)
		ifTrue:  [ parsed := aBenchmarkOrSuite. ]
		ifFalse: [ parsed := aBenchmarkOrSuite findTokens: '>.'. ].
	
	((parsed size > 2) or: [parsed size < 1])
				ifTrue: [ Error signal: 'The passed argument has to represent two elements. A class/classname and a method symbol' ].
	
	suiteClass := parsed first.
	
	(suiteClass isKindOf: Class) 
		ifFalse: [ suiteClass := Smalltalk at: (suiteClass asSymbol) ifAbsent: [Error signal: 'Class that was supposed to represent a benchmark suite was not found: ', suiteClass asString ]].
	
	parsed size = 1
		ifTrue: [^suiteClass].

	specificBenchmark := parsed second asSymbol.
	
	^ { suiteClass. specificBenchmark }
