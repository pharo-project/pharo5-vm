as yet unclassified
computeSlopeAtMSecs: mSecs
	"Private! Find the next inflection point of this envelope and compute its target volume and the number of milliseconds until the inflection point is reached."

	| t i |
	((loopEndMSecs ~~ nil) and: [mSecs >= loopEndMSecs]) ifTrue: [  "decay phase"
		t := (points at: loopEndIndex) x + (mSecs - loopEndMSecs).
		i := self indexOfPointAfterMSecs: t startingAt: loopEndIndex.
		i == nil ifTrue: [  "past end"
			targetVol := points last y * decayScale.
			mSecsForChange := 0.
			nextRecomputeTime := mSecs + 1000000.
			^ self].
		targetVol := (points at: i) y * decayScale.
		mSecsForChange := (((points at: i) x - t) min: (endMSecs - mSecs)) max: 4.
		nextRecomputeTime := mSecs + mSecsForChange.
		^ self].

	mSecs < loopStartMSecs ifTrue: [  "attack phase"
		i := self indexOfPointAfterMSecs: mSecs startingAt: 1.
		targetVol := (points at: i) y.
		mSecsForChange := ((points at: i) x - mSecs) max: 4.
		nextRecomputeTime := mSecs + mSecsForChange.
		((loopEndMSecs ~~ nil) and: [nextRecomputeTime > loopEndMSecs])
			ifTrue: [nextRecomputeTime := loopEndMSecs].
		^ self].

	"sustain and loop phase"
	noChangesDuringLoop ifTrue: [
		targetVol := (points at: loopEndIndex) y.
		mSecsForChange := 10.
		loopEndMSecs == nil
			ifTrue: [nextRecomputeTime := mSecs + 10]  "unknown end time"
			ifFalse: [nextRecomputeTime := loopEndMSecs].
		^ self].

	loopMSecs = 0 ifTrue: [^ (points at: loopEndIndex) y].  "looping on a single point"
	t := loopStartMSecs + ((mSecs - loopStartMSecs) \\ loopMSecs).
	i := self indexOfPointAfterMSecs: t startingAt: loopStartIndex.
	targetVol := (points at: i) y.
	mSecsForChange := ((points at: i) x - t) max: 4.
	nextRecomputeTime := (mSecs + mSecsForChange) min: loopEndMSecs.
