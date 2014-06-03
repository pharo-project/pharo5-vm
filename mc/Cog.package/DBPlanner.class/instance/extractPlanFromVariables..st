planning
extractPlanFromVariables: variables
	"Extract a plan from the dataflow graph having the given variables. It
	 is assumed that the given set of variables is complete, or at least
	 that it contains all the input variables."

	| sources |
	sources := OrderedCollection new.
	variables do:
		[: v |
		 (v constraints) do:
			[: c | (c isInput and: [c isSatisfied]) ifTrue: [sources add: c]]].
	^self makePlan: sources