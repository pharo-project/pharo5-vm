utilities
convert8bitUnsignedTo16Bit: anArray
	"Convert the given array of samples--assumed to be 8-bit unsigned, linear data--into 16-bit signed samples. Return an array containing the resulting samples. Typically used to read uncompressed WAVE sound data."

	| n samples s |
	n := anArray size.
	samples := SoundBuffer newMonoSampleCount: n.
	1 to: n do: [:i |
		s := anArray at: i.
		samples at: i put: (s - 128 * 256)].
	^ samples
