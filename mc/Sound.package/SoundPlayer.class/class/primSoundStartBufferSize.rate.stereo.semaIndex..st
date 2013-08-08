private
primSoundStartBufferSize: bufferSize rate: samplesPerSecond stereo: stereoFlag semaIndex: anInteger
	"Start double-buffered sound output with the given buffer size and sampling rate. If the given semaphore index is > 0, it is taken to be the index of a Semaphore in the external objects array to be signalled when the sound driver is ready to accept another buffer of samples."
	"Details: If this primitive fails, this method tries to use the older version instead."

	<primitive: 'primitiveSoundStartWithSemaphore' module: 'SoundPlugin'>
	UseReadySemaphore := false.
	self primSoundStartBufferSize: bufferSize rate: samplesPerSecond stereo: stereoFlag.
