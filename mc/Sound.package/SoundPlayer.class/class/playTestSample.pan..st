primitive test
playTestSample: s pan: pan
	"Append the given sample in the range [-32767..32767] to the output buffer, playing the output buffer when it is full. Used for testing only."

	| sample leftSample |
	BufferIndex >= Buffer size
		ifTrue: [
			"current buffer is full; play it"
			[self primSoundAvailableBytes > 0]
				whileFalse. "wait for space to be available"
			self primSoundPlaySamples: Buffer stereoSampleCount from: Buffer startingAt: 1.
			Buffer primFill: 0.
			BufferIndex := 1].

	sample := s.
	sample >  32767 ifTrue: [ sample :=  32767 ]. 
	sample < -32767 ifTrue: [ sample := -32767 ].

	Stereo
		ifTrue: [
			leftSample := (sample * pan) // 1000.
			Buffer at: BufferIndex		put: sample - leftSample.
			Buffer at: BufferIndex + 1	put: leftSample]
		ifFalse: [
			Buffer at: BufferIndex + 1 put: sample].
	BufferIndex := BufferIndex + 2.
