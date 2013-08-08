utilities
convertBytesTo16BitSamples: aByteArray mostSignificantByteFirst: msbFirst
	"Convert the given ByteArray (with the given byte ordering) into 16-bit sample buffer."

	| n data src b1 b2 w |
	n := aByteArray size // 2.
	data := SoundBuffer newMonoSampleCount: n.
	src := 1.
	1 to: n do: [:i |
		b1 := aByteArray at: src.
		b2 := aByteArray at: src + 1.
		msbFirst
			ifTrue: [w := (b1 bitShift: 8) + b2]
			ifFalse: [w := (b2 bitShift: 8) + b1].
		w > 32767 ifTrue: [w := w - 65536].
		data at: i put: w.
		src := src + 2].
	^ data
