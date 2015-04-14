utilities
findReadBeforeAssignedIn: variables
	| readBeforeAssigned |
	readBeforeAssigned := Set new.
	parseTree
		addReadBeforeAssignedIn: variables
		to: readBeforeAssigned
		assignments: Set new.
	^readBeforeAssigned