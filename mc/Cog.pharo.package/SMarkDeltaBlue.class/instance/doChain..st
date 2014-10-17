benchmarking
doChain: n

	| vars editConstraint plan planner |

	planner := DBPlanner new.
	vars := (1 to: n+1) collect: [ :i | DBVariable new].

	"thread a chain of equality constraints through the variables"
	1 to: n do:
		[ :i || v1 v2 |
		 v1 := vars at: i.
		 v2 := vars at: i + 1.
		 DBEqualityConstraint var: v1 var: v2 strength: #required].

	DBStayConstraint var: vars last strength: #strongDefault.
	editConstraint := DBEditConstraint var: (vars first) strength: #preferred.
	plan := planner extractPlanFromConstraints: (Array with: editConstraint).
	1 to: 100 do: [ :v | 
		vars first value: v.
		plan execute.
		vars last value ~= v ifTrue: [self error: 'Chain test failed!!']].
	editConstraint destroyConstraint