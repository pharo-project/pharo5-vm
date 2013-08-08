assound
samplesRemaining
	"This message is the cue that the cached sound may no longer be needed.
	We know it is done playing when samplesRemaining=0."

	| samplesRemaining |
	samplesRemaining := cachedSound samplesRemaining.
	samplesRemaining <= 0 ifTrue: [cachedSound := nil].
	^ samplesRemaining