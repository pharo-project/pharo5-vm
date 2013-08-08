debug support
allAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."

	| oop ok |
	ok := true.
	oop := self firstAccessibleObject.
	[oop = nil] whileFalse:
		[ok := ok & (self okayFields: oop).
		 oop := self accessibleObjectAfter: oop].
	^ok