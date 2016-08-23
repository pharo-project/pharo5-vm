weakness and ephemerality
activeAndDeferredScan: anEphemeron
	"Answer whether an ephemeron is active (has an unmarked
	 key) and was pushed on the unscanned ephemerons stack."
	| key |
	<inline: #never>
	self assert: (self isEphemeron: anEphemeron).
	((self isImmediate: (key := self keyOfEphemeron: anEphemeron))
	 or: [self isMarked: key]) ifTrue:
		[^false].
	^self pushOnUnscannedEphemeronsStack: anEphemeron