argument parsing
determineReporter
	(currentObj isKindOf: SMarkReporter)
		ifFalse: [ reporter := harness defaultReporter new. ]
		ifTrue:  [ reporter := currentObj.
			i := i + 1.
			i <= numParams ifTrue: [
				current := arguments at: i.
			]
		].