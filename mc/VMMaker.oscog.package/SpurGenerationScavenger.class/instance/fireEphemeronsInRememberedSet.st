weakness and ephemerality
fireEphemeronsInRememberedSet
	"There are ephemerons to be fired in the remembered set.
	 Fire them and scavenge their keys.  Leave it to scavengeLoop
	 to remove any scavenged ephemerons that no longer have
	 new referents."
	| i |
	self assert: self noUnfiredEphemeronsAtEndOfRememberedSet.

	i := 0.
	[i < numRememberedEphemerons] whileTrue:
		[ | ephemeron key |
		 ephemeron := rememberedSet at: i.
		 self assert: (manager isEphemeron: ephemeron).
		 key := manager keyOfEphemeron: ephemeron.
		 (self isScavengeSurvivor: key) ifFalse:
			[coInterpreter fireEphemeron: ephemeron.
			 manager
				storePointerUnchecked: 0
				ofObject: ephemeron
				withValue: (self copyAndForward: key)].
		 "Fired ephemerons should have had their format changed."
		 self deny: ((self isScavengeSurvivor: key) and: [manager isEphemeron: ephemeron]).
		 (self scavengeReferentsOf: ephemeron)
			ifTrue: "keep in set"
				[i := i + 1]
			ifFalse:
				[manager setIsRememberedOf: ephemeron to: false.
				"remove from set by overwriting with next-to-be scanned"
				 numRememberedEphemerons := numRememberedEphemerons - 1.
				 previousRememberedSetSize := previousRememberedSetSize - 1.
				 rememberedSetSize := rememberedSetSize - 1.
				 "First overwrite with last firable ephemeron (could be a noop if this is the last one).
				  Then overwrite last firable entry with next unscanned rememberedSet entry (could also be a noop).
				  Then overwrite next unscanned entry with last unscanned rememberedSet entry (could also be a noop)."
				 rememberedSet
					at: i
						put: (rememberedSet at: numRememberedEphemerons);
					at: numRememberedEphemerons
						put: (rememberedSet at: previousRememberedSetSize);
					at: previousRememberedSetSize
						put: (rememberedSet at: rememberedSetSize)]].

	"no more firable ephemerons in this cycle.
	 scavengeRememberedSetStartingAt: may find new ones."
	numRememberedEphemerons := 0