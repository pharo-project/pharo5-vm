private
readMergedStereoChannelDataFrom: s
	"Read stereophonic channel data from the given stream, mixing the two channels to create a single monophonic channel. Each frame contains two samples."

	| buf w1 w2 |
	buf := channelData at: 1.
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				w1 := s next.
				w1 > 127 ifTrue: [w1 := w1 - 256].
				w2 := s next.
				w2 > 127 ifTrue: [w2 := w2 - 256].
				buf at: i put: ((w1 + w2) bitShift: 7)]]
		ifFalse: [
			1 to: frameCount do: [:i |
				w1 := (s next bitShift: 8) + s next.
				w1 > 32767 ifTrue: [w1 := w1 - 65536].
				w2 := (s next bitShift: 8) + s next.
				w2 > 32767 ifTrue: [w2 := w2 - 65536].
				buf at: i put: ((w1 + w2) bitShift: -1)]].
