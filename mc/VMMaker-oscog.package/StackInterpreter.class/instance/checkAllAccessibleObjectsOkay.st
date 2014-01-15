debug support
checkAllAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."
	<api>
	| ok oop |
	ok := true.
	oop := objectMemory firstAccessibleObject.
	[oop = nil] whileFalse:
		[ok := ok & (self checkOkayFields: oop).
		oop := objectMemory accessibleObjectAfter: oop].
	^ok