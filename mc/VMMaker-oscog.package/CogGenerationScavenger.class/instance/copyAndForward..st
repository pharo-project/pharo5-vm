api
copyAndForward: survivor
	"copyAndForward: survivor copies a survivor object either to
	 futureSurvivorSpace or, if it is to be promoted, to oldSpace.
	 It leaves a forwarding pointer behind."
	<var: #survivor type: #'object *'>
	| newLocation |
	newLocation := (self shouldBeTenured: survivor)
						ifTrue: [self copyToOldSpace: survivor]
						ifFalse: [self copyToFutureSpace: survivor].
	manager forward: survivor to: newLocation
			