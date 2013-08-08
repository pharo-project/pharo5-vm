compress/decompress
compressSound: aSound
	"Compress the entirety of the given sound with this codec. Answer a CompressedSoundData."

	| compressed channels |
	compressed := CompressedSoundData new
		codecName: self class name;
		soundClassName: aSound class name.
	(aSound isKindOf: SampledSound) ifTrue: [
		channels := Array new: 1.
		channels at: 1 put: (self encodeSoundBuffer: aSound samples).
		compressed
			channels: channels;
			samplingRate: aSound originalSamplingRate;
			firstSample: 1;
			loopEnd: aSound samples size;
			loopLength: 0.0;
			perceivedPitch: 100.0;
			gain: aSound loudness.
		^ compressed].
	(aSound isKindOf: LoopedSampledSound) ifTrue: [
		aSound isStereo
			ifTrue: [
				channels := Array new: 2.
				channels at: 1 put: (self encodeSoundBuffer: aSound leftSamples).
				channels at: 2 put: (self encodeSoundBuffer: aSound rightSamples)]
			ifFalse: [
				channels := Array new: 1.
				channels at: 1 put: (self encodeSoundBuffer: aSound leftSamples)].
		compressed
			channels: channels;
			samplingRate: aSound originalSamplingRate;
			firstSample: aSound firstSample;
			loopEnd: aSound loopEnd;
			loopLength: aSound loopLength;
			perceivedPitch: aSound perceivedPitch;
			gain: aSound gain.
		^ compressed].
	self error: 'you can only compress sampled sounds'.
