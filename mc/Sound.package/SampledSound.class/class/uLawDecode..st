utilities
uLawDecode: aByteArray
	"Convert the given array of uLaw-encoded 8-bit samples into a SoundBuffer of 16-bit signed samples."

	| n out decodingTable |
	n := aByteArray size.
	out := SoundBuffer newMonoSampleCount: n.
	decodingTable := self uLawDecodeTable.
	1 to: n do: [:i | out at: i put: (decodingTable at: (aByteArray at: i) + 1)].
	^ out
