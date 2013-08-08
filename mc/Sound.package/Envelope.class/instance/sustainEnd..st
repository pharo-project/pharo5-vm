applying
sustainEnd: mSecs
	"Set the ending time of the sustain phase of this envelope; the decay phase will start this point. Typically derived from a note's duration."
	"Details: to avoid a sharp transient, the decay phase is scaled so that the beginning of the decay matches the envelope's instantaneous value when the decay phase starts."

	| vIfSustaining firstVOfDecay |
	loopEndMSecs := nil. "pretend to be sustaining"
	decayScale := 1.0.
	nextRecomputeTime := 0.
	vIfSustaining := self computeValueAtMSecs: mSecs.  "get value at end of sustain phase"
	loopEndMSecs := mSecs.
	firstVOfDecay := (points at: loopEndIndex) y * scale.
	firstVOfDecay = 0.0
		ifTrue: [decayScale := 1.0]
		ifFalse: [decayScale := vIfSustaining / firstVOfDecay].
