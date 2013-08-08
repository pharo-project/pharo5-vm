misc
randomBitsFromSoundInput: bitCount
	"Answer a positive integer with the given number of random bits of 'noise' from a sound input source. Typically, one would use a microphone or line input as the sound source, although many sound cards have enough thermal noise that you get random low-order sample bits even with no microphone connected. Only the least signficant bit of the samples is used. Since not all sound cards support 16-bits of sample resolution, we use the lowest bit that changes."
	"(1 to: 10) collect: [:i | BaseSoundSystem new randomBitsFromSoundInput: 512]"

	| recorder buf mid samples bitMask randomBits bit |
	"collect some sound data"
	recorder := SoundRecorder new clearRecordedSound.
	recorder resumeRecording.
	(Delay forSeconds: 1) wait.
	recorder stopRecording.
	buf := recorder condensedSamples.

	"grab bitCount samples from the middle"
	mid := buf monoSampleCount // 2.
	samples := buf copyFrom: mid to: mid + bitCount - 1.

	"find the least significant bit that varies"
	bitMask := 1.
	[bitMask < 16r10000 and:
	 [(samples collect: [:s | s bitAnd: bitMask]) asSet size < 2]]
		whileTrue: [bitMask := bitMask bitShift: 1].
	bitMask = 16r10000 ifTrue: [^ self error: 'sound samples do not vary'].

	"pack the random bits into a positive integer"
	randomBits := 0.
	1 to: samples size do: [:i |
		bit := ((samples at: i) bitAnd: bitMask) = 0 ifTrue: [0] ifFalse: [1].
		randomBits := (randomBits bitShift: 1) + bit].

	^ randomBits	
