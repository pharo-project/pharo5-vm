adding
removeFromGraph
	"Remove myself from the constraint graph."

	v1 ifNotNil: [v1 removeConstraint: self].
	v2 ifNotNil: [v2 removeConstraint: self].
	direction := nil.