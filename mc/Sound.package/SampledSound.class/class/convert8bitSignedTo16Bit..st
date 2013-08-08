utilities
convert8bitSignedTo16Bit: aByteArray
	"Convert the given array of samples--assumed to be 8-bit signed, linear data--into 16-bit signed samples. Return an array containing the resulting samples. Typically used to read uncompressed AIFF sound data."

	| result |
	result := SoundBuffer newMonoSampleCount: aByteArray size.
	self convert8bitSignedFrom: aByteArray to16Bit: result.
	^ result
