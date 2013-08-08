recording controls
stopRecording
	"Turn off the sound input process and close the driver."

	super stopRecording.
	recordedBuffers := nil.
	mutex := nil.
