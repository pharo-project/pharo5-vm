private
allocateBuffer
	"Allocate a new buffer and reset nextIndex. This message is sent by the sound input process."

	currentBuffer := SoundBuffer newMonoSampleCount: bufferSize.
	nextIndex := 1.
