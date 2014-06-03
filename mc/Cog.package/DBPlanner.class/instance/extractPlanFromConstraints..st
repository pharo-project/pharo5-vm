planning
extractPlanFromConstraints: constraints
	"Extract a plan for resatisfaction starting from the outputs of the
	 given constraints, usually a set of input constraints."

	| sources |
	sources := OrderedCollection new.
	constraints do:
		[: c | (c isInput and: [c isSatisfied]) ifTrue: [sources add: c]].
	^self makePlan: sources