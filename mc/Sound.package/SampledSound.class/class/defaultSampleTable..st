default sound
defaultSampleTable: anArray
	"Set the sample table to be used as the default waveform for playing a score such as the Bach fugue. Array is assumed to contain monaural signed 16-bit sample values."

	DefaultSampleTable := SoundBuffer fromArray: anArray.
