accessing
soundPosition: fraction
	"Jump to the position the given fraction through the sound file. The argument is a number between 0.0 and 1.0."

	| desiredSampleIndex |
	(stream isNil or: [stream closed]) ifTrue: [^ self].
	desiredSampleIndex := ((totalSamples * fraction) truncated max: 0) min: totalSamples.
	codec
		ifNil: [stream position: audioDataStart + (desiredSampleIndex * 2)]
		ifNotNil: [self positionCodecTo: desiredSampleIndex].
	leftoverSamples := SoundBuffer new.
