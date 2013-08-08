utilities
splitStereo
	"Answer an array of two SoundBuffers half the size of the receiver consisting of the left and right channels of the receiver (which is assumed to contain stereo sound data)."

	| n leftBuf rightBuf leftIndex rightIndex |
	n := self monoSampleCount.
	leftBuf := SoundBuffer newMonoSampleCount: n // 2.
	rightBuf := SoundBuffer newMonoSampleCount: n // 2.
	leftIndex := rightIndex := 0.
	1 to: n by: 2 do: [:i |
		leftBuf at: (leftIndex := leftIndex + 1) put: (self at: i).
		rightBuf at: (rightIndex := rightIndex + 1) put: (self at: i + 1)].
	^ Array with: leftBuf with: rightBuf
