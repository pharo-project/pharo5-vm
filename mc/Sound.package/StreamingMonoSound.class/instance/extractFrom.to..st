other
extractFrom: startSecs to: endSecs
	"Extract a portion of this sound between the given start and end times. The current implementation only works if the sound is uncompressed."

	| emptySound first last sampleCount byteStream sndBuf |
	codec ifNotNil: [^ self error: 'only works on uncompressed sounds'].
	emptySound := SampledSound samples: SoundBuffer new samplingRate: streamSamplingRate.
	first := (startSecs * streamSamplingRate) truncated max: 0.
	last := ((endSecs * streamSamplingRate) truncated min: totalSamples) - 1.
	first >= last ifTrue: [^ emptySound].
	codec ifNotNil: [self error: 'extracting from compressed sounds is not supported'].
	sampleCount := last + 1 - first.
	stream position: audioDataStart + (2 * first).
	byteStream := ReadStream on: (stream next: 2 * sampleCount).
	sndBuf := SoundBuffer newMonoSampleCount: sampleCount.
	1 to: sampleCount do: [:i | sndBuf at: i put: byteStream int16].
	^ SampledSound samples: sndBuf samplingRate: streamSamplingRate
