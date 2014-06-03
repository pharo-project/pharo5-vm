planning
inputsKnown: mark
	"Assume that I am satisfied. Answer true if all my current inputs are
	 known. A variable is known if either a) it is 'stay' (i.e. it is a
	 constant at plan execution time), b) it has the given mark (indicating
	 that it has been computed by a constraint appearing earlier in the
	 plan), or c) it is not determined by any constraint."

	self inputsDo:
		[ :v |
		 (v mark = mark or: [v stay or: [v determinedBy isNil]]) ifFalse:
			[^false]].
	^true