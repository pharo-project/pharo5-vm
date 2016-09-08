weakness and ephemerality
scavengeUnfiredEphemeronsOnEphemeronList
	"There may be ephemerons to be scavenged on the ephemeronList.
	 Scavenge any with unfired (live) keys, removing them from the
	 list, and answer if any with unfired keys were found."
	| unfiredEphemeronsScavenged corpseOffset previousCorpse |
	ephemeronList ifNil:
		[^false].
	unfiredEphemeronsScavenged := false.
	corpseOffset := ephemeronList.
	[corpseOffset ~= 0] whileTrue:
		[| ephemeronCorpse ephemeron nextCorpseOffset  |
		 ephemeronCorpse := self corpseForCorpseOffset: corpseOffset.
		 self assert: (manager isForwarded: ephemeronCorpse).
		 ephemeron := manager followForwarded: ephemeronCorpse.
		 nextCorpseOffset := self nextCorpseOffset: ephemeronCorpse.
		 (self isScavengeSurvivor: (manager keyOfEphemeron: ephemeron))
			ifTrue:
				[corpseOffset = ephemeronList
					ifTrue: [ephemeronList := nextCorpseOffset ~= 0 ifTrue: [nextCorpseOffset]]
					ifFalse: [self setCorpseOffsetOf: previousCorpse to: nextCorpseOffset].
				 unfiredEphemeronsScavenged := true.
				 self cCoerceSimple: (self scavengeReferentsOf: ephemeron) to: #void]
			ifFalse:
				[previousCorpse := ephemeronCorpse].
		 corpseOffset := nextCorpseOffset].
	^unfiredEphemeronsScavenged