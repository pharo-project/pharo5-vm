adding
removeFromGraph
	"Remove myself from the constraint graph."

	output ifNotNil: [ :out | out removeConstraint: self].
	satisfied := false.