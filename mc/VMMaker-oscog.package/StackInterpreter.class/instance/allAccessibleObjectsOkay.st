debug support
allAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."
	| ok |
	ok := true.
	objectMemory allObjectsDo:
		[:oop|
		ok := ok & (self okayFields: oop)].
	^ok