max / min
strongest: aStrength
	"Answer the stronger of myself and aStrength."

	^ (aStrength stronger: self)
		ifTrue: [aStrength]
		ifFalse: [self]