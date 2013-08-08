applying
valueAtMSecs: mSecs
	"Return the value of this envelope at the given number of milliseconds from its onset. Return zero for times outside the time range of this envelope."

	mSecs < 0 ifTrue: [^ 0.0].
	mSecs < nextRecomputeTime
		ifTrue: [currValue := currValue + valueIncr]
		ifFalse: [currValue := self incrementalComputeValueAtMSecs: mSecs].
	^ currValue
