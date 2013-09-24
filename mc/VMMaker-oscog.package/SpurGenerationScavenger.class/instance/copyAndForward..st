scavenger
copyAndForward: survivor
	"copyAndForward: survivor copies a survivor object either to
	 futureSurvivorSpace or, if it is to be promoted, to oldSpace.
	 It leaves a forwarding pointer behind."
	<inline: true>
	| bytesInObject newLocation |
	bytesInObject := manager bytesInObject: survivor.
	newLocation := ((self shouldBeTenured: survivor)
					  or: [futureSurvivorStart + bytesInObject > futureSpace limit])
						ifTrue: [self copyToOldSpace: survivor]
						ifFalse: [self copyToFutureSpace: survivor bytes: bytesInObject].
	manager forward: survivor to: newLocation.
	^newLocation