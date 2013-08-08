private
readMonoChannelDataFrom: s
	"Read monophonic channel data from the given stream. Each frame contains a single sample."

	| buf w |
	buf := channelData at: 1.  "the only buffer"
	bitsPerSample = 8
		ifTrue: [
			1 to: frameCount do: [:i |
				w := s next.
				w > 127 ifTrue: [w := w - 256].
				buf at: i put: (w bitShift: 8)]]
		ifFalse: [
			1 to: frameCount do: [:i |
				w := (s next bitShift: 8) + s next.
				w > 32767 ifTrue: [w := w - 65536].
				buf at: i put: w]].
