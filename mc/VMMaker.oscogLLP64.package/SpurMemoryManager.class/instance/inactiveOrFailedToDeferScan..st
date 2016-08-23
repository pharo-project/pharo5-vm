weakness and ephemerality
inactiveOrFailedToDeferScan: anEphemeron
	"Answer whether an ephemeron is inactive (has a marked key) or,
	 if active, failed to fit on the unscanned ephemerons stack."
	| key |
	self assert: (self isEphemeron: anEphemeron).
	((self isImmediate: (key := self keyOfEphemeron: anEphemeron))
	 or: [self isMarked: key]) ifTrue:
		[^true].
	^(self pushOnUnscannedEphemeronsStack: anEphemeron) not