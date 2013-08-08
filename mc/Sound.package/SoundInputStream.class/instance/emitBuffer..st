private
emitBuffer: buffer
	"Queue a buffer for later processing. This message is sent by the sound input process."

	mutex critical: [recordedBuffers addLast: buffer].
