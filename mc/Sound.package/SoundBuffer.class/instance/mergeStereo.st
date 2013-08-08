utilities
mergeStereo
	"Answer a new SoundBuffer half the size of the receiver that mixes the left and right stereo channels of the receiver, which is assumed to contain stereo sound data."

	| n resultBuf j |
	n := self monoSampleCount.
	resultBuf := SoundBuffer newMonoSampleCount: n // 2.
	j := 0.
	1 to: n by: 2 do: [:i | resultBuf at: (j := j + 1) put: (((self at: i) + (self at: i + 1)) // 2)].
	^ resultBuf
