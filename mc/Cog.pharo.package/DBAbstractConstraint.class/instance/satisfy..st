planning
satisfy: mark
	"Attempt to find a way to enforce this (still unsatisfied) constraint.
	 If successful, record the solution, perhaps modifying the current
	 dataflow graph.  Answer the constraint that this constraint overrides,
	 if there is one, or nil, if there isn't."

	| overridden out |
	self chooseMethod: mark.
	self isSatisfied
		ifTrue:			"constraint can be satisfied"
			["mark inputs to allow cycle detection in addPropagate"
			 self inputsDo: [ :in | in mark: mark].
			 out := self output.
			 overridden := out determinedBy.
			 overridden ifNotNil: [overridden markUnsatisfied].
			 out determinedBy: self.
			 (DBPlanner current addPropagate: self mark: mark) ifFalse:
				[self notify:
					('Cycle encountered adding:\   ',
					 self printString,
					 '\Constraint removed.') withCRs.
				 ^nil].
			 out mark: mark]
		ifFalse:			"constraint cannot be satisfied"
			[overridden := nil.
			 (strength sameAs: (DBStrength required)) ifTrue:
				[self notify: 'Failed to satisfy a required constraint']].
	^ overridden