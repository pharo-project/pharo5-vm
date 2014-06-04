weakness and ephemerality
markAllUnscannedEphemerons
	"After firing the unscanned ephemerons we must scan-mark them.
	 The wrinkle is that doing so may add more ephemerons to the set."
	| ptr |
	self assert: (self noUnscannedEphemerons) not.
	self assert: self allUnscannedEphemeronsAreActive.
	ptr := unscannedEphemerons top - self wordSize.
	[ptr >= unscannedEphemerons start] whileTrue:
		[| ephemeron key |
		 key := self keyOfEphemeron: (ephemeron := self longAt: ptr).
		 self markAndTrace: key;
			markAndTrace: ephemeron.
		 unscannedEphemerons top: unscannedEphemerons top - self wordSize.
		 ptr < unscannedEphemerons top ifTrue:
			["not the last entry; remove it by overwriting it with the last
			  ephemeron (which must have been newly added by markAndTrace:)."
			 self longAt: ptr put: (self longAt: unscannedEphemerons top)].
		ptr := ptr - self wordSize]