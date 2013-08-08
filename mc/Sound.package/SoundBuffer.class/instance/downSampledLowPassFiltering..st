utilities
downSampledLowPassFiltering: doFiltering
	"Answer a new SoundBuffer half the size of the receiver consisting of every other sample. If doFiltering is true, a simple low-pass filter is applied to avoid aliasing of high frequencies. Assume that receiver is monophonic."
	"Details: The simple low-pass filter in the current implementation could be improved, at some additional cost."

	| n resultBuf j |
	n := self monoSampleCount.
	resultBuf := SoundBuffer newMonoSampleCount: n // 2.
	j := 0.
	doFiltering
		ifTrue: [
			1 to: n by: 2 do: [:i |
				resultBuf at: (j := j + 1) put:
					(((self at: i) + (self at: i + 1)) bitShift: -1)]]
		ifFalse: [
			1 to: n by: 2 do: [:i |
				resultBuf at: (j := j + 1) put: (self at: i)]].

	^ resultBuf