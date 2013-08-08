compress/decompress
decompressSound: aCompressedSound
	"Decompress the entirety of the given compressed sound with this codec and answer the resulting sound."

	| channels sound |
	channels := aCompressedSound channels
		collect: [:compressed | self decodeCompressedData: compressed].
	'SampledSound' = aCompressedSound soundClassName ifTrue: [
		sound := SampledSound
			samples: channels first
			samplingRate: (aCompressedSound samplingRate).
		sound loudness: aCompressedSound gain.
		^ sound].
	'LoopedSampledSound' = aCompressedSound soundClassName ifTrue: [
		aCompressedSound loopLength = 0
			ifTrue: [
				sound := LoopedSampledSound
					unloopedSamples: channels first
					pitch: aCompressedSound perceivedPitch
					samplingRate: aCompressedSound samplingRate]
			ifFalse: [
				sound := LoopedSampledSound
					samples: channels first
					loopEnd: aCompressedSound loopEnd
					loopLength: aCompressedSound loopLength
					pitch: aCompressedSound perceivedPitch
					samplingRate: aCompressedSound samplingRate].
		channels size > 1 ifTrue: [sound rightSamples: channels last].
		sound
			firstSample: aCompressedSound firstSample;
			gain: aCompressedSound gain.
		sound
			setPitch: 100.0
			dur: (channels first size / aCompressedSound samplingRate)
			loudness: 1.0.
		^ sound].
	self error: 'unknown sound class'.
