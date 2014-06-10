processing-voice
pitchSynchronousReset
	<returnTypeC: 'void'>
	(frame at: F0) > 0
		ifTrue: [self voicedPitchSynchronousReset.
				periodCount := periodCount + 1 \\ 65535]
		ifFalse: [t0 := 1.
				nmod := t0]