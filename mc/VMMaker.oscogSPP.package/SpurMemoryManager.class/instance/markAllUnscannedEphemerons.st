weakness and ephemerality
markAllUnscannedEphemerons
	"After firing the unscanned ephemerons we must scan-mark them.
	 The wrinkle is that doing so may add more ephemerons to the set.
	 So we remove the first element, by overwriting it with the last element,
	 and decrementing the top, and then markAndTrace its contents."
	self assert: (self noUnscannedEphemerons) not.
	self assert: self allUnscannedEphemeronsAreActive.
	[unscannedEphemerons top > unscannedEphemerons start] whileTrue:
		[| ephemeron key lastptr |
		 ephemeron := self longAt: unscannedEphemerons start.
		 lastptr := unscannedEphemerons top - self bytesPerOop.
		 lastptr > unscannedEphemerons start ifTrue:
			[self longAt: unscannedEphemerons start put: (self longAt: lastptr)].
		 unscannedEphemerons top: lastptr.
		 key := self followedKeyOfMaybeFiredEphemeron: ephemeron.
		 self setIsMarkedOf: ephemeron to: false. "to get it to be fully scanned in markAndTrace:"
		 self
			markAndTrace: key;
			markAndTrace: ephemeron]