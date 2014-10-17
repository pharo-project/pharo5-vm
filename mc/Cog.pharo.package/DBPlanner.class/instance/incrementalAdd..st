adding
incrementalAdd: c
	"Attempt to satisfy the given constraint and, if successful,
	 incrementally update the dataflow graph.

	 Details: If satifying the constraint is successful, it may override a
	 weaker constraint on its output. The algorithm attempts to resatisfy
	 that constraint using some other method. This process is repeated
	 until either a) it reaches a variable that was not previously
	 determined by any constraint or b) it reaches a constraint that
	 is too weak to be satisfied using any of its methods. The variables
	 of constraints that have been processed are marked with a unique mark
	 value so that we know where we've been. This allows the algorithm to
	 avoid getting into an infinite loop even if the constraint graph has
	 an inadvertent cycle."

	| mark overridden |
	mark := self newMark.
	overridden := c satisfy: mark.
	[overridden isNil] whileFalse:
		[overridden := overridden satisfy: mark].