debug support
allAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."
	| ok |
	ok := true.
	objectMemory allObjectsDoSafely:
		[:oop|
		ok := ok & (self okayFields: oop)].
	^ok