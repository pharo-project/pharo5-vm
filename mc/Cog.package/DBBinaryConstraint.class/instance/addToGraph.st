adding
addToGraph
	"Add myself to the constraint graph."

	v1 addConstraint: self.
	v2 addConstraint: self.
	direction := nil.