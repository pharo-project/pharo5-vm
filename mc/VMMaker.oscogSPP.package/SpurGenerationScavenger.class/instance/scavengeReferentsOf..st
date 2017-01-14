scavenger
scavengeReferentsOf: referrer
	"scavengeReferentsOf: referrer inspects all the pointers in referrer.  If
	 any are new objects, it has them moved to FutureSurvivorSpace, and
	 answers truth. If there are no new referents, it answers falsity. To handle
	 weak arrays, if the referrer is weak only scavenge strong slots and answer
	 true so that it won't be removed from the remembered set until later."
	| fmt foundNewReferentOrIsWeakling numSlots |
	"forwarding objects should be followed by callers,
	 unless the forwarder is a root in the remembered table."
	self assert: ((manager isForwarded: referrer) not
				or: [manager isRemembered: referrer]).
	"unscanned ephemerons should be scanned later."
	self assert: ((manager isEphemeron: referrer) not
				or: [(self isScavengeSurvivor: (manager keyOfEphemeron: referrer))
				or: [self is: referrer onWeaklingList: ephemeronList]]).
	fmt := manager formatOf: referrer.
	foundNewReferentOrIsWeakling := manager isWeakFormat: fmt.
	numSlots := manager numStrongSlotsOf: referrer format: fmt ephemeronInactiveIf: #isScavengeSurvivor:.
	0 to: numSlots - 1 do:
		[:i| | referent newLocation |
		referent := manager fetchPointer: i ofMaybeForwardedObject: referrer.
		(manager isNonImmediate: referent) ifTrue:
			["a forwarding pointer could be because of become: or scavenging."
			 (manager isForwarded: referent) ifTrue:
				[referent := manager followForwarded: referent].
			 (manager isReallyYoungObject: referent)
				ifTrue: "if target is already in future space forwarding pointer was due to a become:."
					[(manager isInFutureSpace: referent)
						ifTrue: [newLocation := referent. foundNewReferentOrIsWeakling := true]
						ifFalse:
							[newLocation := self copyAndForward: referent.
							 (manager isYoung: newLocation) ifTrue:
								[foundNewReferentOrIsWeakling := true]].
					 manager storePointerUnchecked: i ofMaybeForwardedObject: referrer withValue: newLocation]
				ifFalse:
					[manager storePointerUnchecked: i ofMaybeForwardedObject: referrer withValue: referent]]].
	^foundNewReferentOrIsWeakling