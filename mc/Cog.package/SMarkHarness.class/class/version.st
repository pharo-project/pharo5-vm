helper
version
	(Smalltalk classNamed: #ConfigurationOfBenchmarking)
		ifNotNilDo: [:cfg |
			^ cfg project currentVersion versionNumber asString.
		].
	  
	(Smalltalk classNamed: #MCPackage)
		ifNotNilDo: [:mcp |
			| package |
			package := mcp named: 'SMark'.
			package hasWorkingCopy ifTrue: [
				^ package workingCopy ancestors first name.
			].
		].
	
	^ ''.