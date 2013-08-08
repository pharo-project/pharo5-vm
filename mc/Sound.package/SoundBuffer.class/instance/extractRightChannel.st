utilities
extractRightChannel
	"Answer a new SoundBuffer half the size of the receiver consisting of only the right channel of the receiver, which is assumed to contain stereo sound data."

	| n resultBuf j |
	n := self monoSampleCount.
	resultBuf := SoundBuffer newMonoSampleCount: n // 2.
	j := 0.
	2 to: n by: 2 do: [:i | resultBuf at: (j := j + 1) put: (self at: i)].
	^ resultBuf