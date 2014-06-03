planning
makePlan: sources
	"Extract a plan for resatisfaction starting from the given satisfied
	 source constraints, usually a set of input constraints. This method
	 assumes that stay optimization is desired; the plan will contain only
	 constraints whose output variables are not stay. Constraints that do
	 no computation, such as stay and edit constraints, are not included
	 in the plan.

	 Details: The outputs of a constraint are marked when it is added to
	 the plan under construction. A constraint may be appended to the plan
	 when all its input variables are known. A variable is known if either
	 a) the variable is marked (indicating that has been computed by a
	 constraint appearing earlier in the plan), b) the variable is 'stay'
	 (i.e. it is a constant at plan execution time), or c) the variable
	 is not determined by any constraint. The last provision is for past
	 states of history variables, which are not stay but which are also
	 not computed by any constraint."

	| mark plan todo c |
	mark := self newMark.
	plan := DBPlan new.
	todo := sources.
	[todo isEmpty] whileFalse:
		[c := todo removeFirst.
		 ((c output mark ~= mark) and:		"not in plan already and..."
		  [c inputsKnown: mark]) ifTrue:	"eligible for inclusion"
			[plan addLast: c.
			 c output mark: mark.
			 self addConstraintsConsuming: c output to: todo]].
	^ plan