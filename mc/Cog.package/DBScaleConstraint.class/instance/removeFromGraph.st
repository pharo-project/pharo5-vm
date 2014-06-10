adding
removeFromGraph
	"Remove myself from the constraint graph."

	super removeFromGraph.
	scale ifNotNil: [scale removeConstraint: self].
	offset ifNotNil: [offset removeConstraint: self].
