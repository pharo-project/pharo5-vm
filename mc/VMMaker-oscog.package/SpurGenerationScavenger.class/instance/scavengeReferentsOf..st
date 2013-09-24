scavenger
scavengeReferentsOf: referrer
	"scavengeReferentsOf: referrer inspects all the pointers in referrer.
	 If any are new objects, it has them moved to FutureSurvivorSpace,
	 and answers truth. If there are no new referents, it answers falsity."
	| foundNewReferent |
	"forwarding objects should be followed by callers,
	 unless the forwarder is a root in the remembered table."
	self assert: ((manager isForwarded: referrer) not
				or: [manager isRemembered: referrer]).
	foundNewReferent := false.
	0 to: (manager numPointerSlotsOf: referrer) - 1 do:
		[:i| | referent newLocation |
		referent := manager fetchPointer: i ofMaybeForwardedObject: referrer.
		(manager isNonImmediate: referent) ifTrue:
			["a forwarding pointer could be because of become: or scavenging."
			 referent := (manager isForwarded: referent)
								ifTrue: [manager followForwarded: referent]
								ifFalse: [referent].
			 (manager isYoung: referent)
				ifTrue:
					["if target is already in future space forwarding pointer was due to a become:."
					 (manager isInFutureSpace: referent)
						ifTrue: [newLocation := referent]
						ifFalse:
							[(manager isForwarded: referent)
								ifTrue: [self halt. "can this even happen?"
									newLocation := manager followForwarded: referent]
								ifFalse: [newLocation := self copyAndForward: referent]].
					 (manager isYoung: newLocation) ifTrue:
						[foundNewReferent := true].
					 manager storePointerUnchecked: i ofMaybeForwardedObject: referrer withValue: newLocation]
				ifFalse:
					[manager storePointerUnchecked: i ofMaybeForwardedObject: referrer withValue: referent]]].
	^foundNewReferent