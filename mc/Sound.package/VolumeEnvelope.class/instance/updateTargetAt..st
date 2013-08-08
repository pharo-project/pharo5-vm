as yet unclassified
updateTargetAt: mSecs
	"Update the volume envelope slope and limit for my target. Answer false."

	mSecs < nextRecomputeTime ifTrue: [^ false].
	self computeSlopeAtMSecs: mSecs.
	mSecsForChange < 5 ifTrue: [mSecsForChange := 5].  "don't change instantly to avoid clicks"
	target adjustVolumeTo: targetVol * scale overMSecs: mSecsForChange.
	^ false
