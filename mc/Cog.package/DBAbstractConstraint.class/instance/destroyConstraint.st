adding
destroyConstraint
	"Deactivate this constraint, remove it from the constraint graph,
	 possibly causing other constraints to be satisfied, and destroy it."

	(self isSatisfied) ifTrue: [DBPlanner current incrementalRemove: self].
	self removeFromGraph.
	self release.