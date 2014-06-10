primitives
primitiveSoundStartBufferSize: bufFrames rate: samplesPerSec stereo: stereoFlag semaIndex: semaIndex
	"Start the double-buffered sound output with the given buffer size, sample rate, stereo flag, and semaphore index."

	self primitive: 'primitiveSoundStartWithSemaphore'
		parameters: #(SmallInteger SmallInteger Boolean SmallInteger).
	interpreterProxy success: (self cCode: 'snd_Start(bufFrames, samplesPerSec, stereoFlag, semaIndex)')