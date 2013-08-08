results
condensedSamples
	"Return a single SoundBuffer that is the contatenation of all my recorded buffers."

	| sz newBuf i |
	recordedBuffers := recordedSound sounds collect: [:snd | snd samples].
	recordedBuffers isEmpty ifTrue: [^ SoundBuffer new: 0].
	recordedBuffers size = 1 ifTrue: [^ recordedBuffers first copy].
	sz := recordedBuffers inject: 0 into: [:tot :buff | tot + buff size].
	newBuf := SoundBuffer newMonoSampleCount: sz.
	i := 1.
	recordedBuffers do: [:b |
		1 to: b size do: [:j |
			newBuf at: i put: (b at: j).
			i := i + 1]].
	recordedBuffers := nil.
	^ newBuf
