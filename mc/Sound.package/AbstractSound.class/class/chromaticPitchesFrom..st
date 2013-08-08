examples
chromaticPitchesFrom: aPitch

	| halfStep pitch |
	halfStep := 2.0 raisedTo: (1.0 / 12.0).
	pitch := aPitch isNumber
			ifTrue: [aPitch]
			ifFalse: [self pitchForName: aPitch].
	pitch := pitch / halfStep.
	^ (0 to: 14) collect: [:i | pitch := pitch * halfStep]
