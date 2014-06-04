weakness and ephemerality
fireEphemeronsOnEphemeronList
	"There are ephemerons to be fired in the remembered set.
	 Fire them and scavenge their keys.  Be careful since copyAndForward:
	 can remember ephemerons (ephemerons pointing to ephemerons)."
	| ephemeron ephemeronCorpse |
	ephemeronList ifNil:
		[^self].
	ephemeronCorpse := self firstCorpse: ephemeronList.
	"Reset the list head so that new ephemerons will get added
	 to a new list, not concatenated on the one we are scanning."
	ephemeronList := nil.
	[ephemeronCorpse notNil] whileTrue:
		[self assert: (manager isForwarded: ephemeronCorpse).
		 ephemeron := manager followForwarded: ephemeronCorpse.
		 self assert: (self isScavengeSurvivor: (manager keyOfEphemeron: ephemeron)) not.
		 coInterpreter fireEphemeron: ephemeron.
		 self copyAndForward: (manager keyOfEphemeron: ephemeron).
		 self cCoerceSimple: (self scavengeReferentsOf: ephemeron) to: #void.
		 ephemeronCorpse := self nextCorpseOrNil: ephemeronCorpse]