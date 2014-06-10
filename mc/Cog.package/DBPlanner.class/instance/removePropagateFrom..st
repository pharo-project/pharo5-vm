private
removePropagateFrom: out
	"Update the walkabout strengths and stay flags of all variables
	 downstream of the given constraint. Answer a collection of unsatisfied
	 constraints sorted in order of decreasing strength."

	| unsatisfied todo v |
	unsatisfied := SortedCollection sortBlock:
		[ :c1 :c2 | c1 strength stronger: c2 strength].
	out determinedBy: nil.
	out walkStrength: DBStrength absoluteWeakest.
	out stay: true.
	todo := OrderedCollection with: out.
	[todo isEmpty] whileFalse:
		[v := todo removeFirst.
		 v constraints do:
		 	[ :c | c isSatisfied ifFalse: [unsatisfied add: c]].
		 self constraintsConsuming: v do:
			[ :c |
			 c recalculate.
			 todo add: c output]].
	^ unsatisfied