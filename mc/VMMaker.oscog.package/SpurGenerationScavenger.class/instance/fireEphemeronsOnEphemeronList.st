weakness and ephemerality
fireEphemeronsOnEphemeronList
	"There are ephemerons to be fired in the remembered set.
	 Fire them and scavenge their keys.  Be careful since copyAndForward:
	 can remember ephemerons (ephemerons pointing to ephemerons)."
	| ephemeron ephemeronCorpse key oldList oldCorpse | "old ones for debugging"
	ephemeronList ifNil:
		[^self].
	oldCorpse := nil.
	ephemeronCorpse := self firstCorpse: ephemeronList.
	"Reset the list head so that new ephemerons will get added
	 to a new list, not concatenated on the one we are scanning."
	oldList := ephemeronList.
	ephemeronList := nil.
	[ephemeronCorpse notNil] whileTrue:
		[self assert: ((manager isYoung: ephemeronCorpse) and: [manager isForwarded: ephemeronCorpse]).
		 ephemeron := manager followForwarded: ephemeronCorpse.
		 key := manager keyOfMaybeFiredEphemeron: ephemeron.
		 (self isScavengeSurvivor: key) ifFalse:
			[coInterpreter fireEphemeron: ephemeron.
			 manager
				storePointerUnchecked: 0
				ofObject: ephemeron
				withValue: (self copyAndForward: key)].
		 "Fired ephemerons should have had their format changed."
		 self deny: ((self isScavengeSurvivor: key) and: [manager isEphemeron: ephemeron]).
		 self cCoerceSimple: (self scavengeReferentsOf: ephemeron) to: #void.
		 oldCorpse := ephemeronCorpse.
		 ephemeronCorpse := self nextCorpseOrNil: ephemeronCorpse]