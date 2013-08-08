primitives
primStartRecordingDesiredSampleRate: samplesPerSec stereo: stereoFlag semaIndex: anInteger
	"Start sound recording with the given stereo setting. Use a sampling rate as close to the desired rate as the underlying platform will support. If the given semaphore index is > 0, it is taken to be the index of a Semaphore in the external objects array to be signalled every time a recording buffer is filled."

	<primitive: 'primitiveSoundStartRecording' module: 'SoundPlugin'>
	self primitiveFailed
