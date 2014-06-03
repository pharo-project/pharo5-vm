argument parsing
determineBenchmarkParametersFromArguments
	i := i + 1.
	i <= numParams ifTrue: [
		iterations := (arguments at: i) asInteger.
		i := i + 1.
		i <= numParams ifTrue: [
			processes := (arguments at: i) asInteger.
			i := i + 1.
			i <= numParams ifTrue: [
				problemSize := arguments at: i.
			]
		]
	].