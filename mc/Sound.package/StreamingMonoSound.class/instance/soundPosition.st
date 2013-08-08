accessing
soundPosition
	"Answer the relative position of sound playback as a number between 0.0 and 1.0."

	(stream isNil or: [stream closed]) ifTrue: [^ 0.0].
	^ self currentSampleIndex asFloat / totalSamples
