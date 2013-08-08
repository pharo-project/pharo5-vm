debug support
allAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."
	| ok oop |
	ok := true.
	oop := objectMemory firstAccessibleObject.
	[oop = nil] whileFalse:
		[ok := ok & (self okayFields: oop).
		oop := objectMemory accessibleObjectAfter: oop].
	^ok