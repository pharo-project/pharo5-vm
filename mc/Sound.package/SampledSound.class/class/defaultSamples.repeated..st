default sound
defaultSamples: anArray repeated: n

	| data |
	data := WriteStream on: (SoundBuffer newMonoSampleCount: anArray size * n).
	n timesRepeat: [
		anArray do: [:sample | data nextPut: sample truncated]].
	DefaultSampleTable := data contents.
