weakness and ephemerality
scavengeUnfiredEphemeronsInRememberedSet
	"There are ephemerons to be scavenged in the remembered set.
	 Scavenge any with unfired (live) keys, removing them from the
	 unscavenged ephemerons, and from the set if they no longer refer
	 to new objects, and answer if any with unfired keys were found."
	| unfiredEphemeronsScavenged i referrer hasNewReferents |
	unfiredEphemeronsScavenged := false.
	i := 0.
	[i < numRememberedEphemerons] whileTrue:
		[referrer := rememberedSet at: i.
		 self assert: (manager isEphemeron: referrer).
		 (self isScavengeSurvivor: (manager keyOfEphemeron: referrer))
			ifTrue:
				[unfiredEphemeronsScavenged := true.
				 hasNewReferents := self scavengeReferentsOf: referrer.
				 "remove from unscanned ephemerons in set by swapping with last ephemeron"
				 numRememberedEphemerons := numRememberedEphemerons - 1.
				 rememberedSet
					at: i
					put: (rememberedSet at: numRememberedEphemerons).
				 hasNewReferents
					ifTrue: "keep in set"
						[rememberedSet
							at: numRememberedEphemerons
							put: referrer]
					ifFalse: "remove from set by overwriting with next-to-be scanned"
						[previousRememberedSetSize := previousRememberedSetSize - 1.
						 rememberedSetSize := rememberedSetSize - 1.
						 rememberedSet
							at: numRememberedEphemerons
								put: (rememberedSet at: previousRememberedSetSize);
							at: previousRememberedSetSize
								put: (rememberedSet at: rememberedSetSize).
						 manager setIsRememberedOf: referrer to: false]]
				ifFalse:
					[i := i + 1]].
	^unfiredEphemeronsScavenged