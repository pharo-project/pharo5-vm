private
incrementalComputeValueAtMSecs: mSecs
	"Compute the current value, per-step increment, and the time of the next inflection point."
	"Note: This method is part of faster, but less general, way of computing envelope values. It depends on a known, fixed control updating rate."

	| t i |
	((loopEndMSecs ~~ nil) and: [mSecs >= loopEndMSecs]) ifTrue: [  "decay phase"
		t := (points at: loopEndIndex) x + (mSecs - loopEndMSecs).
		i := self indexOfPointAfterMSecs: t startingAt: loopEndIndex.
		i == nil ifTrue: [  "past end"
			currValue := points last y * scale * decayScale.
			valueIncr := 0.0.
			nextRecomputeTime := mSecs + 1000000.
			^ currValue].
		nextRecomputeTime := mSecs + ((points at: i) x - t).
		^ self computeIncrementAt: t
			between: (points at: i - 1)
			and: (points at: i)
			scale: scale * decayScale].

	mSecs < loopStartMSecs
		ifTrue: [  "attack phase"
			t := mSecs.
			i := self indexOfPointAfterMSecs: t startingAt: 1.
			nextRecomputeTime := mSecs + ((points at: i) x - t)]
		ifFalse: [  "sustain (looping) phase"
			noChangesDuringLoop ifTrue: [
				currValue := (points at: loopEndIndex) y * scale.
				valueIncr := 0.0.
				loopEndMSecs == nil
					ifTrue: [nextRecomputeTime := mSecs + 10]  "unknown end time"
					ifFalse: [nextRecomputeTime := loopEndMSecs].
				^ currValue].
			t := loopStartMSecs + ((mSecs - loopStartMSecs) \\ loopMSecs).
			i := self indexOfPointAfterMSecs: t startingAt: loopStartIndex.
			nextRecomputeTime := (mSecs + ((points at: i) x - t)) min: loopEndMSecs].

	^ self computeIncrementAt: t
		between: (points at: i - 1)
		and: (points at: i)
		scale: scale.
