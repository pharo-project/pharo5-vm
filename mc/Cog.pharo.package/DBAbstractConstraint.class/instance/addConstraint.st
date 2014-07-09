adding
addConstraint
	"Activate this constraint and attempt to satisfy it."

	self addToGraph.
	DBPlanner current incrementalAdd: self.