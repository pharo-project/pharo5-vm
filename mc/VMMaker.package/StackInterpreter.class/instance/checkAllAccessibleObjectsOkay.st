debug support
checkAllAccessibleObjectsOkay
	"Ensure that all accessible objects in the heap are okay."
	<api>
	| ok |
	ok := true.
	objectMemory allObjectsDoSafely:
		[:oop| ok := ok & (self checkOkayFields: oop)].
	^ok