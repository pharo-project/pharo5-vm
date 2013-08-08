applying
computeValueAtMSecs: mSecs
	"Return the value of this envelope at the given number of milliseconds from its onset. Return zero for times outside the time range of this envelope."
	"Note: Unlike the private method incrementalComputeValueAtMSecs:, this method does is not increment. Thus it is slower, but it doesn't depend on being called sequentially at fixed time intervals."

	| t i |
	mSecs < 0 ifTrue: [^ 0.0].

	((loopEndMSecs ~~ nil) and: [mSecs >= loopEndMSecs]) ifTrue: [  "decay phase"
		t := (points at: loopEndIndex) x + (mSecs - loopEndMSecs).
		i := self indexOfPointAfterMSecs: t startingAt: loopEndIndex.
		i == nil ifTrue: [^ 0.0].  "past end"
		^ (self interpolate: t between: (points at: i - 1) and: (points at: i)) * decayScale].

	mSecs < loopStartMSecs ifTrue: [  "attack phase"
		i := self indexOfPointAfterMSecs: mSecs startingAt: 1.
		i = 1 ifTrue: [^ (points at: 1) y * scale].
		^ self interpolate: mSecs between: (points at: i - 1) and: (points at: i)].

	"sustain phase"
	loopMSecs = 0 ifTrue: [^ (points at: loopEndIndex) y * scale].  "looping on a single point"
	t := loopStartMSecs + ((mSecs - loopStartMSecs) \\ loopMSecs).
	i := self indexOfPointAfterMSecs: t startingAt: loopStartIndex.

	^ self interpolate: t between: (points at: i - 1) and: (points at: i)
