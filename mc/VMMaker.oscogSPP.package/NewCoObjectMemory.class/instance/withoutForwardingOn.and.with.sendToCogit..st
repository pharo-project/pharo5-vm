cog jit support
withoutForwardingOn: obj1 and: obj2 with: aBool sendToCogit: selector
	"For the purposes of become: send selector to the cogit with obj1, obj2 and aBool, and
	 answer the result. Undo forwarding for the selector, but redo forwarding after since
	 become:'s restoreHeadersAfter*Become* methods expect to be able to restore."
	<api>
	<var: #selector declareC: 'sqInt (*selector)(sqInt,sqInt,sqInt)'>
	| savedHeaderA savedHeaderB result |
	savedHeaderA := self baseHeader: obj1.
	self baseHeader: obj1 put: (self headerWhileForwardingOf: obj1).
	savedHeaderB := self baseHeader: obj2.
	self baseHeader: obj2 put: (self headerWhileForwardingOf: obj2).

	result := cogit perform: selector with: obj1 with: obj2 with: aBool.

	self baseHeader: obj1 put: savedHeaderA.
	self baseHeader: obj2 put: savedHeaderB.
	^result