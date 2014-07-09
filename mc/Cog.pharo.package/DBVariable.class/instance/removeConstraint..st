accessing
removeConstraint: c
	"Remove all traces of c from this variable."

	constraints remove: c ifAbsent: [].
	determinedBy == c ifTrue: [determinedBy := nil].