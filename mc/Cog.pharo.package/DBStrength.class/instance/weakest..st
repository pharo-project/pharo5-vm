max / min
weakest: aStrength
	"Answer the weaker of myself and aStrength."

	^ (aStrength weaker: self)
		ifTrue: [aStrength]
		ifFalse: [self].