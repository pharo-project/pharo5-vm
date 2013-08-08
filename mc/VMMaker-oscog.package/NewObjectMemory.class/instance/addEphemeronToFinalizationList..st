ephemerons
addEphemeronToFinalizationList: oop

	"add ephemeron to its finalization list, in order to notify language side that it's key are almost collectable"
	<inline: true>

	| list next |
	list := self fetchPointer: 0 ofObject: oop.
	next := self fetchPointer: 0 ofObject: list.
	      
	self storePointerUnchecked: 1 ofObject: oop withValue: next.
	self storePointerUnchecked: 0 ofObject: list withValue: oop.
	"mark it as reported"
	self markEphemeronAsReported: oop 