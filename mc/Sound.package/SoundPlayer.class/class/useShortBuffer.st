initialization
useShortBuffer
	"Experimental support for real-time MIDI input. This only works on platforms whose hardware allows very short buffer sizes. It has been tested on a Macintosh Powerbook G3."
	"SoundPlayer useShortBuffer"

	self shutDown.
	BufferMSecs := 15.
	SoundPlayer
		startPlayerProcessBufferSize: (BufferMSecs * SamplingRate) // 1000
		rate: SamplingRate
		stereo: Stereo.
