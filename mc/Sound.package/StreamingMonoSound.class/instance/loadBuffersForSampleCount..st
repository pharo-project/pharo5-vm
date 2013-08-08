private
loadBuffersForSampleCount: count
	"Load the sound buffers from the stream."

	| snd buf sampleCount |
	snd := mixer sounds first.
	buf := snd samples.
	buf monoSampleCount = count ifFalse: [
		buf := SoundBuffer newMonoSampleCount: count.
		snd setSamples: buf samplingRate: streamSamplingRate].
	sampleCount := count min: (totalSamples - self currentSampleIndex).
	sampleCount < count ifTrue: [buf primFill: 0].

	codec
		ifNil: [self loadBuffer: buf uncompressedSampleCount: sampleCount]
		ifNotNil: [self loadBuffer: buf compressedSampleCount: sampleCount].

	mixer reset.
