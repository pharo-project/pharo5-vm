weakness and ephemerality
fireAllUnscannedEphemerons
	self assert: (self noUnscannedEphemerons) not.
	self assert: self allUnscannedEphemeronsAreActive.
	unscannedEphemerons start to: unscannedEphemerons top - self wordSize do:
		[:p|
		self queueEphemeron: (self longAt: p)].
	coInterpreter forceInterruptCheck