utilities
findReadBeforeAssignedIn: variables in: aCodeGen
	| readBeforeAssigned |
	readBeforeAssigned := Set new.
	parseTree
		addReadBeforeAssignedIn: variables
		to: readBeforeAssigned
		assignments: Set new
		in: aCodeGen.
	^readBeforeAssigned