adding
addToGraph
	"Add myself to the constraint graph."

	super addToGraph.
	scale addConstraint: self.
	offset addConstraint: self.
