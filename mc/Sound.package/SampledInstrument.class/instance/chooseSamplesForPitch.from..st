other
chooseSamplesForPitch: pitchInHz from: sortedNotes
	"From the given collection of LoopedSampledSounds, choose the best one to be pitch-shifted to produce the given pitch."
	"Assume: the given collection is sorted in ascending pitch order."

	| i lower higher |
	i := 1.
	[(i < sortedNotes size) and: [(sortedNotes at: i) pitch < pitchInHz]]
		whileTrue: [i := i + 1].
	i = 1 ifTrue: [^ sortedNotes at: 1].
	lower := sortedNotes at: i - 1.
	higher := sortedNotes at: i.
	"note: give slight preference for down-shifting a higher-pitched sample set"
	(pitchInHz / lower pitch) < ((0.95 * higher pitch) / pitchInHz)
		ifTrue: [^ lower]
		ifFalse: [^ higher].
