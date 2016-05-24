weakness and ephemerality
pushOnUnscannedEphemeronsStack: anEphemeron
	"Attempt to push anEphemeron on the unscanned ephemerons stack
	 and answer if the attempt succeeded.  Note that the ephemeron
	 stack overflowing isn't a disaster; it simply means treating the
	 ephemeron as strong in this GC cycle."
	<inline: false>
	self assert: (self isEphemeron: anEphemeron).
	unscannedEphemerons top >= unscannedEphemerons limit ifTrue:
		[^false].
	self longAt: unscannedEphemerons top put: anEphemeron.
	unscannedEphemerons top: unscannedEphemerons top + self bytesPerOop.
	^true