weakness and ephemerality
markInactiveEphemerons
	"Go through the unscanned ephemerons, marking the inactive ones, and
	 removing them from the unscanned ephemerons. Answer if any inactive
	 ones were found. We cannot fire the ephemerons until all are found to
	 be active since scan-marking an inactive ephemeron later in the set may
	 render a previously-observed active ephemeron as inactive."
	| foundInactive ptr |
	foundInactive := false.
	ptr := unscannedEphemerons start.
	[ptr < unscannedEphemerons top] whileTrue:
		[| ephemeron key |
		 key := self followedKeyOfEphemeron: (ephemeron := self longAt: ptr).
		 ((self isImmediate: key) or: [self isMarked: key])
			ifTrue:
				[foundInactive := true.
				 "Now remove the inactive ephemeron from the set, and scan-mark it.
				  Scan-marking it may add more ephemerons to the set."
				 unscannedEphemerons top: unscannedEphemerons top - self bytesPerOop.
				 unscannedEphemerons top > ptr ifTrue:
					[self longAt: ptr put: (self longAt: unscannedEphemerons top)].
				 self markAndTrace: ephemeron]
			ifFalse:
				[ptr := ptr + self bytesPerOop]].
	^foundInactive