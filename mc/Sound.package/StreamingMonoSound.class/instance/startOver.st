private
startOver
	"Jump back to the first sample."

	stream reopen; binary.
	self readHeader.
	stream position: audioDataStart.
	leftoverSamples := SoundBuffer new.
	lastBufferMSecs := 0.
	mutex := Semaphore forMutualExclusion.
