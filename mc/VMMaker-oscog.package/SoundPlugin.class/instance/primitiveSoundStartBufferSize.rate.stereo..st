primitives
primitiveSoundStartBufferSize: bufFrames rate: samplesPerSec stereo: stereoFlag
	"Start the double-buffered sound output with the given buffer size, sample rate, and stereo flag."

	self primitive: 'primitiveSoundStart'
		parameters: #(SmallInteger SmallInteger Boolean).
	interpreterProxy success: (self cCode: 'snd_Start(bufFrames, samplesPerSec, stereoFlag, 0)')