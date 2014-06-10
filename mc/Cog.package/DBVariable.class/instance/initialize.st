initialize
initialize

	super initialize.

	value := 0.
	constraints := OrderedCollection new: 2.
	determinedBy := nil.
	walkStrength := DBStrength absoluteWeakest.
	stay := true.
	mark := 0.