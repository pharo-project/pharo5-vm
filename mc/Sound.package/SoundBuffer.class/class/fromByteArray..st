instance creation
fromByteArray: aByteArray
	"Convert the given ByteArray (stored with the most significant byte first) into 16-bit sample buffer."

	| n buf src w |
	n := aByteArray size // 2.
	buf := SoundBuffer newMonoSampleCount: n.
	src := 1.
	1 to: n do: [:i |
		w := ((aByteArray at: src) bitShift: 8) + (aByteArray at: src + 1).
		w > 32767 ifTrue: [w := w - 65536].
		buf at: i put: w.
		src := src + 2].
	^ buf
