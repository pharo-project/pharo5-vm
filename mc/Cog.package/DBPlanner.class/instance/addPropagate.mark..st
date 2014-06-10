private
addPropagate: c mark: mark
	"Recompute the walkabout strengths and stay flags of all variables
	 downstream of the given constraint and recompute the actual values
	 of all variables whose stay flag is true. If a cycle is detected,
	 remove the given constraint and answer false. Otherwise, answer true.

	 Details: Cycles are detected when a marked variable is encountered
	 downstream of the given constraint. The sender is assumed to have
	 marked the inputs of the given constraint with the given mark. Thus,
	 encountering a marked node downstream of the output constraint means
	 that there is a path from the constraint's output to one of its
	 inputs."

	| todo d |
	todo := OrderedCollection with: c.
	[todo isEmpty] whileFalse:
		[d := todo removeFirst.
		 (d output mark = mark) ifTrue:
			[self incrementalRemove: c.
			 ^ false].
		 d recalculate.
		 self addConstraintsConsuming: d output to: todo].
	^ true