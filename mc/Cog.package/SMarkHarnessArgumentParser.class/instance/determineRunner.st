argument parsing
determineRunner
	(currentObj isKindOf: SMarkRunner)
		ifFalse: [ runner := harness defaultRunner new. ]
		ifTrue:  [ runner := currentObj.
			i := i + 1.
			i <= numParams ifTrue: [
				current := arguments at: i.
				currentObj := (Smalltalk classNamed: current) ifNotNilDo: [:cls | cls new].
			]
		].