scavenger
scavengeRememberedSetStartingAt: n
	"scavengeRememberedSetStartingAt: n traverses objects in the remembered
	 set starting at the nth one.  If the object does not refer to any new objects, it
	 is removed from the set.  Otherwise, its new referents are scavenged.  Defer
	 scavenging ephemerons until after a complete scavenge has been performed,
	 so that triggered ephemerons can be fired.  Move them to the front of the set
	 and count them in numRememberedEphemerons for later scanning."
	<inline: false>
	| destIndex sourceIndex referrer |
	sourceIndex := destIndex := n.
	[sourceIndex < rememberedSetSize] whileTrue:
		["*Don't* follow forwarding pointers here. oldSpace objects may refer
		  to these roots, and so they can't be removed in the scavenge."
		referrer := rememberedSet at: sourceIndex.
		"Any potential firing ephemerons should not be scanned yet.
		 Move any to the front of the set to save time in later scanning."
		((manager isEphemeron: referrer)
		 and: [(self isScavengeSurvivor: ((manager keyOfEphemeron: referrer))) not])
			ifTrue:
				[self assert: destIndex >= numRememberedEphemerons.
				 rememberedSet
					at: destIndex put: (rememberedSet at: numRememberedEphemerons);
					at: numRememberedEphemerons put: referrer.
				 numRememberedEphemerons := numRememberedEphemerons + 1.
				 destIndex := destIndex + 1]
			ifFalse:
				[(self scavengeReferentsOf: referrer)
					ifTrue:
						[rememberedSet at: destIndex put: referrer.
						 destIndex := destIndex + 1]
					ifFalse:
						[manager setIsRememberedOf: referrer to: false]].
		 sourceIndex := sourceIndex + 1].
	rememberedSetSize := destIndex.
	self assert: self noUnfiredEphemeronsAtEndOfRememberedSet